import 'package:http/http.dart' as http;

class ApiRequester {
  static String host = 'rickandmortyapi.com';

  Future<http.Response> getResponse(
      String path, Map<String, dynamic>? queryParameters) async {
    Uri url = Uri.https(host, "/api$path", queryParameters);
    return await http.get(url);
  }
}
