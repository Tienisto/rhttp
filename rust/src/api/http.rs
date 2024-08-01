use anyhow::Result;
use reqwest::{Method, Url, Version};

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

pub enum HttpVersionPref {
    Http1,
    Http2,
    Http3,
    All,
}

pub enum HttpVersion {
    Http09,
    Http10,
    Http11,
    Http2,
    Http3,
    Other,
}

pub struct HttpResult {
    pub headers: Vec<(String, String)>,
    pub version: HttpVersion,
    pub status_code: u16,
    pub body: String,
}

pub async fn make_http_request(
    method: HttpMethod,
    url: String,
    http_version: HttpVersionPref,
) -> Result<HttpResult> {
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
        let request = client.request(method.to_method(), Url::parse(&url)?);
        match http_version {
            HttpVersionPref::Http1 => request.version(Version::HTTP_10),
            HttpVersionPref::Http2 => request.version(Version::HTTP_2),
            HttpVersionPref::Http3 => request.version(Version::HTTP_3),
            HttpVersionPref::All => request,
        }.build()?
    };

    let response = client.execute(request).await?;

    Ok(HttpResult {
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
        body: response.text().await?,
    })
}
