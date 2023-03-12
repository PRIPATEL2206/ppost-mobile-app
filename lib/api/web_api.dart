import 'package:http/http.dart';

class WebApi {
  final Client _webClint;

  const WebApi(this._webClint);

  // get
  Future<Response> get(
    String url, {
    Map<String, String>? header,
  }) async {
    final uri = Uri.parse(url);
    return await _webClint.get(uri, headers: header);
  }

// post
  Future<Response> post(
    String url, {
    required Map<String, String> header,
    required Object body,
  }) async {
    final uri = Uri.parse(url);

    return await _webClint.post(uri, headers: header, body: body);
  }

// put
  Future<Response> put(
    String url, {
    required Map<String, String> header,
    required Object body,
  }) async {
    final uri = Uri.parse(url);

    return await _webClint.put(uri, headers: header, body: body);
  }
}
