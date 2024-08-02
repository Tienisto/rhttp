use std::collections::HashMap;
use std::str::FromStr;
use anyhow::Result;
use reqwest::{Method, Url, Version};
use reqwest::header::{HeaderName, HeaderValue};
use crate::api::http_types::HttpHeaderName;

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
}

pub enum HttpBody {
    Text(String),
    Bytes(Vec<u8>),
    Form(HashMap<String, String>),
}

pub enum HttpVersionPref {
    Http1,
    Http2,
    Http3,
    All,
}

pub enum HttpExpectBody {
    Text,
    Bytes,
    Stream,
}

pub enum HttpVersion {
    Http09,
    Http10,
    Http11,
    Http2,
    Http3,
    Other,
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

pub async fn make_http_request(
    http_version: HttpVersionPref,
    method: HttpMethod,
    url: String,
    query: Option<Vec<(String, String)>>,
    headers: Option<HttpHeaders>,
    body: Option<HttpBody>,
    expect_body: HttpExpectBody,
) -> Result<HttpResponse> {
    let client = {
        let client = reqwest::Client::builder();
        match http_version {
            HttpVersionPref::Http1 => client.http1_only(),
            HttpVersionPref::Http2 => client.http2_prior_knowledge(),
            HttpVersionPref::Http3 => client.http3_prior_knowledge(),
            HttpVersionPref::All => client,
        }.build()?
    };

    let request = {
        let mut request = client.request(method.to_method(), Url::parse(&url)?);

        request = match http_version {
            HttpVersionPref::Http1 => request.version(Version::HTTP_10),
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
            },
            Some(HttpHeaders::RawMap(map)) => {
                for (k, v) in map {
                    let header_name = HeaderName::from_str(&k)?;
                    let header_value = HeaderValue::from_str(&v)?;
                    request = request.header(header_name, header_value);
                }
            },
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

    let response = client.execute(request).await?;

    Ok(HttpResponse {
        headers: response.headers().iter().map(|(k, v)| (k.as_str().to_string(), v.to_str().unwrap().to_string())).collect(),
        version: match response.version() {
            Version::HTTP_09 => HttpVersion::Http09,
            Version::HTTP_10 => HttpVersion::Http10,
            Version::HTTP_11 => HttpVersion::Http11,
            Version::HTTP_2 => HttpVersion::Http2,
            Version::HTTP_3 => HttpVersion::Http3,
            _ => HttpVersion::Other,
        },
        status_code: response.status().as_u16(),
        body: match expect_body {
            HttpExpectBody::Text => HttpResponseBody::Text(response.text().await?),
            HttpExpectBody::Bytes => HttpResponseBody::Bytes(response.bytes().await?.to_vec()),
            HttpExpectBody::Stream => HttpResponseBody::Stream,
        },
    })
}
