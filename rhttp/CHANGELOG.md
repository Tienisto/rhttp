## 0.6.1

- feat: add `onSendProgress` and `onReceiveProgress`
- feat: increase performance of `HttpBody.stream`
- feat: always compile Rust in release mode

## 0.6.0

- feat: add `HttpBody.stream` to send a stream as request body
- feat: `RhttpCompatibleClient` sets `throwOnStatusCode` to `false` to conform with `http` package

## 0.5.4

- feat: wrap any exception in `RhttpCompatibleClient` into `RhttpWrappedClientException`

## 0.5.3

- feat: add `RhttpConnectionException` to catch connection errors like no internet, server not reachable, etc.
- feat: add `RhttpCompatibleClient.createSync`
- feat: add `cancelRunningRequests` parameter to `RhttpClient.dispose`
- fix: creating a client with HTTP/3 fails with `no async runtime found`

## 0.5.2

- fix: `RetryInterceptor` should throw `RhttpCancelException` if request is canceled during retry

## 0.5.1

- feat: add `RhttpClient.createSync`
- feat: add `HttpHeaders.copyWith`, `HttpHeaders.copyWithout`
- feat: add convenience method: `HttpTextResponse.bodyToJson`
- fix: reset parameters in `RetryInterceptor.shouldRetry` before retrying

## 0.5.0

- feat: interceptors (e.g. `RetryInterceptor`)
- feat: certificate pinning
- feat: client certificate / mutual TLS
- feat: add `ProxySettings`
- **BREAKING**: `requestGeneric` renamed to `request`, `request` removed

## 0.4.0

- feat: add `RhttpCompatibleClient` that is compatible with the [http](https://pub.dev/packages/http) package

## 0.3.2

- docs: update README

## 0.3.1

- docs: add benchmark

## 0.3.0

- feat: add `HttpBody.multipart`
- feat: change `TlsSettings.verifyCerts` to `TlsSettings.verifyCertificates`

## 0.2.0

- feat: add `RhttpStatusCodeException`, `RhttpInvalidCertificateException`
- feat: add `TlsSettings`

## 0.1.0

- feat: request body types
- feat: client for connection pooling / reuse
- feat: cancel requests
- feat: improve error handling with `RhttpException`

## 0.0.2

- feat: query, headers, body

## 0.0.1

- initial release
