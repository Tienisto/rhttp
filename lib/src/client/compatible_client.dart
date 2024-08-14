import 'package:http/http.dart';
import 'package:rhttp/src/client/rhttp_client.dart';
import 'package:rhttp/src/interceptor/interceptor.dart';
import 'package:rhttp/src/model/request.dart';
import 'package:rhttp/src/model/settings.dart';

/// An HTTP client that is compatible with the `http` package.
/// This minimizes the changes needed to switch from `http` to `rhttp`
/// and also avoids vendor lock-in.
///
/// This comes with some downsides, such as:
/// - inferior type safety due to the flaw that `body` is of type `Object?`
///   instead of a sane supertype.
/// - body of type [Map] is implicitly interpreted as `x-www-form-urlencoded`
///   that is only documented in StackOverflow (as of writing this).
/// - no support for cancellation
/// - no out-of-the-box support for multipart requests
class RhttpCompatibleClient with BaseClient {
  /// The actual client that is used to make requests.
  final RhttpClient client;

  RhttpCompatibleClient._(this.client);

  static Future<RhttpCompatibleClient> create({
    ClientSettings? settings,
    List<Interceptor>? interceptors,
  }) async {
    final client = await RhttpClient.create(
      settings: settings,
      interceptors: interceptors,
    );
    return RhttpCompatibleClient._(client);
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    try {
      final response = await client.requestStream(
        method: switch (request.method) {
          'GET' => HttpMethod.get,
          'POST' => HttpMethod.post,
          'PUT' => HttpMethod.put,
          'PATCH' => HttpMethod.patch,
          'DELETE' => HttpMethod.delete,
          'HEAD' => HttpMethod.head,
          'OPTIONS' => HttpMethod.options,
          'TRACE' => HttpMethod.trace,
          'CONNECT' => HttpMethod.connect,
          _ => throw ArgumentError('Unsupported method: ${request.method}'),
        },
        url: request.url.toString(),
        headers: HttpHeaders.rawMap(request.headers),
        body: HttpBody.bytes(await request.finalize().toBytes()),
      );

      final responseHeaderMap = response.headerMap;

      return StreamedResponse(
        response.body,
        response.statusCode,
        contentLength: switch (responseHeaderMap['content-length']) {
          String s => int.parse(s),
          null => null,
        },
        request: request,
        headers: responseHeaderMap,
        isRedirect: false,

        // TODO
        persistentConnection: true,

        // TODO: Is this even relevant nowadays?
        reasonPhrase: null,
      );
    } catch (e) {
      throw ClientException(e.toString(), request.url);
    }
  }

  @override
  void close() {
    client.dispose();
  }
}
