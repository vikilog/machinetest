import 'package:http/http.dart' as http;

class ApiService {
  Future<http.Response> get(String url) async {
    return http.get(Uri.parse(url));
  }

  Future<http.Response> post(String url,
      {Map<String, String>? headers, body}) async {
    return http.post(Uri.parse(url), headers: headers, body: body);
  }

  Future<http.Response> put(String url,
      {Map<String, String>? headers, body}) async {
    return http.put(Uri.parse(url), headers: headers, body: body);
  }

  Future<http.Response> delete(String url,
      {Map<String, String>? headers, body}) async {
    return http.delete(Uri.parse(url), headers: headers, body: body);
  }
}
