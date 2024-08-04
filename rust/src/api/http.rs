use std::collections::HashMap;
use std::str::FromStr;

use crate::api::client::ClientSettings;
use crate::api::client_pool::RequestClient;
use crate::api::http_types::HttpHeaderName;
use crate::api::{client_pool, request_pool};
use crate::frb_generated::StreamSink;
use anyhow::Result;
use flutter_rust_bridge::DartFnFuture;
use futures_util::StreamExt;
use reqwest::header::{HeaderName, HeaderValue};
use reqwest::{Method, Response, Url, Version};
use tokio_util::sync::CancellationToken;

pub enum HttpMethod {
    Options,
    Get,
    Post,
    Put,
    Delete,
    Head,
    Trace,
    Connect,
    Patch,
}

impl HttpMethod {
    fn to_method(&self) -> Method {
        match self {
            HttpMethod::Options => Method::OPTIONS,
            HttpMethod::Get => Method::GET,
            HttpMethod::Post => Method::POST,
            HttpMethod::Put => Method::PUT,
            HttpMethod::Delete => Method::DELETE,
            HttpMethod::Head => Method::HEAD,
            HttpMethod::Trace => Method::TRACE,
            HttpMethod::Connect => Method::CONNECT,
            HttpMethod::Patch => Method::PATCH,
        }
    }
}

pub enum HttpHeaders {
    Map(HashMap<HttpHeaderName, String>),
    RawMap(HashMap<String, String>),
    List(Vec<(String, String)>),
}

pub enum HttpBody {
    Text(String),
    Bytes(Vec<u8>),
    Form(HashMap<String, String>),
}

#[derive(Clone, Copy)]
pub enum HttpVersionPref {
    Http10,
    Http11,
    Http2,
    Http3,
    All,
}

pub enum HttpExpectBody {
    Text,
    Bytes,
}

pub enum HttpVersion {
    Http09,
    Http10,
    Http11,
    Http2,
    Http3,
    Other,
}

impl HttpVersion {
    fn from_version(version: Version) -> HttpVersion {
        match version {
            Version::HTTP_09 => HttpVersion::Http09,
            Version::HTTP_10 => HttpVersion::Http10,
            Version::HTTP_11 => HttpVersion::Http11,
            Version::HTTP_2 => HttpVersion::Http2,
            Version::HTTP_3 => HttpVersion::Http3,
            _ => HttpVersion::Other,
        }
    }
}

pub struct HttpResponse {
    pub headers: Vec<(String, String)>,
    pub version: HttpVersion,
    pub status_code: u16,
    pub body: HttpResponseBody,
}

pub enum HttpResponseBody {
    Text(String),
    Bytes(Vec<u8>),
    Stream,
}

pub fn register_client(settings: ClientSettings) -> Result<i64> {
    let (address, _) = client_pool::register_client(settings)?;

    Ok(address)
}

pub fn remove_client(address: i64) {
    client_pool::remove_client(address);
}

pub async fn make_http_request(
    client_address: Option<i64>,
    settings: Option<ClientSettings>,
    method: HttpMethod,
    url: String,
    query: Option<Vec<(String, String)>>,
    headers: Option<HttpHeaders>,
    body: Option<HttpBody>,
    expect_body: HttpExpectBody,
    on_cancel_token: impl Fn(i64) -> DartFnFuture<()>,
    cancelable: bool,
) -> Result<HttpResponse> {
    if cancelable {
        let token = CancellationToken::new();
        let cloned_token = token.clone();

        let address = request_pool::register_token(token);
        on_cancel_token(address).await;

        tokio::select! {
            _ = cloned_token.cancelled() => Err(anyhow::anyhow!("Request cancelled")),
            response = make_http_request_inner(client_address, settings, method, url, query, headers, body, expect_body) => {
                request_pool::remove_token(address);
                response
            },
        }
    } else {
        // request is not cancelable
        make_http_request_inner(
            client_address,
            settings,
            method,
            url,
            query,
            headers,
            body,
            expect_body,
        )
        .await
    }
}

async fn make_http_request_inner(
    client_address: Option<i64>,
    settings: Option<ClientSettings>,
    method: HttpMethod,
    url: String,
    query: Option<Vec<(String, String)>>,
    headers: Option<HttpHeaders>,
    body: Option<HttpBody>,
    expect_body: HttpExpectBody,
) -> Result<HttpResponse> {
    let response =
        make_http_request_helper(client_address, settings, method, url, query, headers, body)
            .await?;

    Ok(HttpResponse {
        headers: header_to_vec(response.headers()),
        version: HttpVersion::from_version(response.version()),
        status_code: response.status().as_u16(),
        body: match expect_body {
            HttpExpectBody::Text => HttpResponseBody::Text(response.text().await?),
            HttpExpectBody::Bytes => HttpResponseBody::Bytes(response.bytes().await?.to_vec()),
        },
    })
}

pub async fn make_http_request_receive_stream(
    client_address: Option<i64>,
    settings: Option<ClientSettings>,
    method: HttpMethod,
    url: String,
    query: Option<Vec<(String, String)>>,
    headers: Option<HttpHeaders>,
    body: Option<HttpBody>,
    stream_sink: StreamSink<Vec<u8>>,
    on_response: impl Fn(HttpResponse) -> DartFnFuture<()>,
) -> Result<()> {
    let response =
        make_http_request_helper(client_address, settings, method, url, query, headers, body)
            .await?;

    let http_response = HttpResponse {
        headers: header_to_vec(response.headers()),
        version: HttpVersion::from_version(response.version()),
        status_code: response.status().as_u16(),
        body: HttpResponseBody::Stream,
    };

    on_response(http_response).await;

    let stream_sink = stream_sink;
    let mut stream = response.bytes_stream();

    while let Some(chunk) = stream.next().await {
        let chunk = chunk?;
        stream_sink
            .add(chunk.to_vec())
            .map_err(|e| anyhow::anyhow!(e.to_string()))?;
    }

    Ok(())
}

/// This function is used to make an HTTP request without any response handling.
async fn make_http_request_helper(
    client_address: Option<i64>,
    settings: Option<ClientSettings>,
    method: HttpMethod,
    url: String,
    query: Option<Vec<(String, String)>>,
    headers: Option<HttpHeaders>,
    body: Option<HttpBody>,
) -> Result<Response> {
    let client: RequestClient = match client_address {
        Some(address) => client_pool::get_client(address)
            .ok_or_else(|| anyhow::anyhow!("Client with address {} not found", address))?,

        None => match settings {
            Some(settings) => client_pool::create_client(settings)?,
            None => RequestClient::new_default(),
        },
    };

    let request = {
        let mut request = client.client.request(method.to_method(), Url::parse(&url)?);

        request = match client.http_version_pref {
            HttpVersionPref::Http10 => request.version(Version::HTTP_10),
            HttpVersionPref::Http11 => request.version(Version::HTTP_11),
            HttpVersionPref::Http2 => request.version(Version::HTTP_2),
            HttpVersionPref::Http3 => request.version(Version::HTTP_3),
            HttpVersionPref::All => request,
        };

        if let Some(query) = query {
            request = request.query(&query);
        }

        match headers {
            Some(HttpHeaders::Map(map)) => {
                for (k, v) in map {
                    let header_name = k.to_actual_header_name();
                    let header_value = HeaderValue::from_str(&v)?;
                    request = request.header(header_name, header_value);
                }
            }
            Some(HttpHeaders::RawMap(map)) => {
                for (k, v) in map {
                    let header_name = HeaderName::from_str(&k)?;
                    let header_value = HeaderValue::from_str(&v)?;
                    request = request.header(header_name, header_value);
                }
            }
            Some(HttpHeaders::List(list)) => {
                for (k, v) in list {
                    let header_name = HeaderName::from_str(&k)?;
                    let header_value = HeaderValue::from_str(&v)?;
                    request = request.header(header_name, header_value);
                }
            }
            None => (),
        };

        request = match body {
            Some(HttpBody::Text(text)) => request.body(text),
            Some(HttpBody::Bytes(bytes)) => request.body(bytes),
            Some(HttpBody::Form(form)) => request.form(&form),
            None => request,
        };

        request.build()?
    };

    let response = client.client.execute(request).await?;

    Ok(response)
}

fn header_to_vec(headers: &reqwest::header::HeaderMap) -> Vec<(String, String)> {
    headers
        .iter()
        .map(|(k, v)| (k.as_str().to_string(), v.to_str().unwrap().to_string()))
        .collect()
}

pub fn cancel_request(address: i64) {
    if let Some(token) = request_pool::get_token(address) {
        token.cancel();
        request_pool::remove_token(address);
    }
}
