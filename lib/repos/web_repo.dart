import 'package:http/http.dart';
import 'package:ppostman/api/web_api.dart';

class WebRepo {
  final WebApi _webApi;

  WebRepo(this._webApi);

  // get
  Future<Response> get({
    required String url,
    Map<String, String>? header,
  }) async {
    return await _webApi.get(
      url,
      header: header,
    );
  }

// post
  Future<Response> post({
    required String url,
    required Map<String, String> header,
    required Object body,
  }) async {
    return await _webApi.post(
      url,
      header: header,
      body: body,
    );
  }

// put
  Future<Response> put({
    required String url,
    required Map<String, String> header,
    required Object body,
  }) async {
    return await _webApi.put(
      url,
      header: header,
      body: body,
    );
  }
}
