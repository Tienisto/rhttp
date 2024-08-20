use crate::api::error::RhttpError;
use crate::api::http::HttpVersionPref;
use chrono::Duration;
use reqwest::{tls, Certificate};
use tokio_util::sync::CancellationToken;

pub struct ClientSettings {
    pub http_version_pref: HttpVersionPref,
    pub timeout: Option<Duration>,
    pub connect_timeout: Option<Duration>,
    pub throw_on_status_code: bool,
    pub proxy_settings: Option<ProxySettings>,
    pub tls_settings: Option<TlsSettings>,
}

pub enum ProxySettings {
    NoProxy,
}

pub struct TlsSettings {
    pub trust_root_certificates: bool,
    pub trusted_root_certificates: Vec<Vec<u8>>,
    pub verify_certificates: bool,
    pub client_certificate: Option<ClientCertificate>,
    pub min_tls_version: Option<TlsVersion>,
    pub max_tls_version: Option<TlsVersion>,
}

pub struct ClientCertificate {
    pub certificate: Vec<u8>,
    pub private_key: Vec<u8>,
}

pub enum TlsVersion {
    Tls1_2,
    Tls1_3,
}

impl Default for ClientSettings {
    fn default() -> Self {
        ClientSettings {
            http_version_pref: HttpVersionPref::All,
            timeout: None,
            connect_timeout: None,
            throw_on_status_code: true,
            proxy_settings: None,
            tls_settings: None,
        }
    }
}

#[derive(Clone)]
pub(crate) struct RequestClient {
    pub(crate) client: reqwest::Client,
    pub(crate) http_version_pref: HttpVersionPref,
    pub(crate) throw_on_status_code: bool,

    /// A token that can be used to cancel all requests made by this client.
    pub(crate) cancel_token: CancellationToken,
}

impl RequestClient {
    pub(crate) fn new_default() -> Self {
        create_client(ClientSettings::default()).unwrap()
    }

    pub(crate) fn new(settings: ClientSettings) -> Result<RequestClient, RhttpError> {
        create_client(settings)
    }
}

fn create_client(settings: ClientSettings) -> Result<RequestClient, RhttpError> {
    let client: reqwest::Client = {
        let mut client = reqwest::Client::builder();
        if let Some(proxy_settings) = settings.proxy_settings {
            match proxy_settings {
                ProxySettings::NoProxy => client = client.no_proxy(),
            }
        }

        if let Some(timeout) = settings.timeout {
            client = client.timeout(
                timeout
                    .to_std()
                    .map_err(|e| RhttpError::RhttpUnknownError(e.to_string()))?,
            );
        }
        if let Some(timeout) = settings.connect_timeout {
            client = client.connect_timeout(
                timeout
                    .to_std()
                    .map_err(|e| RhttpError::RhttpUnknownError(e.to_string()))?,
            );
        }

        if let Some(tls_settings) = settings.tls_settings {
            if !tls_settings.trust_root_certificates {
                client = client.tls_built_in_root_certs(false);
            }

            for cert in tls_settings.trusted_root_certificates {
                client =
                    client.add_root_certificate(Certificate::from_pem(&cert).map_err(|e| {
                        RhttpError::RhttpUnknownError(format!(
                            "Error adding trusted certificate: {e:?}"
                        ))
                    })?);
            }

            if !tls_settings.verify_certificates {
                client = client.danger_accept_invalid_certs(true);
            }

            if let Some(client_certificate) = tls_settings.client_certificate {
                let identity = &[
                    client_certificate.certificate.as_slice(),
                    "\n".as_bytes(),
                    client_certificate.private_key.as_slice(),
                ]
                .concat();

                client = client.identity(
                    reqwest::Identity::from_pem(identity)
                        .map_err(|e| RhttpError::RhttpUnknownError(format!("{e:?}")))?,
                );
            }

            if let Some(min_tls_version) = tls_settings.min_tls_version {
                client = client.min_tls_version(match min_tls_version {
                    TlsVersion::Tls1_2 => tls::Version::TLS_1_2,
                    TlsVersion::Tls1_3 => tls::Version::TLS_1_3,
                });
            }

            if let Some(max_tls_version) = tls_settings.max_tls_version {
                client = client.max_tls_version(match max_tls_version {
                    TlsVersion::Tls1_2 => tls::Version::TLS_1_2,
                    TlsVersion::Tls1_3 => tls::Version::TLS_1_3,
                });
            }
        }

        client = match settings.http_version_pref {
            HttpVersionPref::Http10 | HttpVersionPref::Http11 => client.http1_only(),
            HttpVersionPref::Http2 => client.http2_prior_knowledge(),
            HttpVersionPref::Http3 => client.http3_prior_knowledge(),
            HttpVersionPref::All => client,
        };

        client
            .build()
            .map_err(|e| RhttpError::RhttpUnknownError(format!("{e:?}")))?
    };

    Ok(RequestClient {
        client,
        http_version_pref: settings.http_version_pref,
        throw_on_status_code: settings.throw_on_status_code,
        cancel_token: CancellationToken::new(),
    })
}
