import 'dart:convert';
import 'dart:typed_data';

import 'package:http_profile/http_profile.dart';
import 'package:rhttp/src/model/request.dart';
import 'package:rhttp/src/model/response.dart';
import 'package:rhttp/src/model/settings.dart';
import 'package:rhttp/src/util/http_header.dart';

HttpClientRequestProfile? createProfileForRequest({
  required HttpRequest request,
  required String url,
  required HttpHeaders? headers,
}) {
  final profile = HttpClientRequestProfile.profile(
    requestStartTime: DateTime.now(),
    requestMethod: request.method.name.toUpperCase(),
    requestUri: switch (request.query?.isNotEmpty ?? false) {
      true => Uri.parse(url).replace(queryParameters: request.query).toString(),
      false => url,
    },
  );

  if (profile == null) {
    return null;
  }

  profile.connectionInfo = {
    'package': 'package:rhttp',
  };

  profile.requestData
    ..headersListValues = headers?.toMapList()
    ..maxRedirects = switch (request.digestedSettings?.redirectSettings) {
      LimitedRedirects limited => limited.maxRedirects,
      NoRedirectSetting _ => 0,
      null => null,
    };

  final Uint8List? body = switch (request.body) {
    HttpBodyText text => utf8.encode(text.text),
    HttpBodyJson json => utf8.encode(jsonEncode(json.json)),
    HttpBodyBytes bytes => bytes.bytes,
    HttpBodyBytesStream _ => utf8.encode('<stream>'),
    HttpBodyForm form => utf8
        .encode(form.form.entries.map((e) => '${e.key}=${e.value}').join('&')),
    HttpBodyMultipart multipart =>
      utf8.encode(multipart.parts.map((e) => '${e.$1}=<TODO>').join('&')),
    null => null,
  };

  if (body != null) {
    profile.requestData.bodySink.add(body);
    profile.requestData.bodySink.close();
  }

  return profile;
}

void populateProfileForResponse({
  required HttpClientRequestProfile? profile,
  required HttpResponse response,
  required Uint8List? streamBody,
}) {
  populateProfileForCustomResponse(
    profile: profile,
    statusCode: response.statusCode,
    headers: response.headers,
    body: switch (response) {
      HttpTextResponse() => utf8.encode(response.body),
      HttpBytesResponse() => response.body,
      HttpStreamResponse() => streamBody!,
    },
  );
}

void populateProfileForCustomResponse({
  required HttpClientRequestProfile? profile,
  required int statusCode,
  required List<(String, String)> headers,
  required Object? body,
}) {
  if (profile == null) {
    return;
  }

  profile.requestData.close();

  profile.responseData
    ..statusCode = statusCode
    ..headersListValues = headers.asHeaderMapList;

  final bodyBytes = switch (body) {
    String() => utf8.encode(body),
    Uint8List() => body,
    _ => null,
  };

  if (bodyBytes != null) {
    profile.responseData.bodySink.add(bodyBytes);
    profile.responseData.bodySink.close();
  }

  profile.responseData.close();
}
