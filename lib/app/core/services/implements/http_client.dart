import 'package:http/http.dart' as http;

import '../intefaces/http_client.dart';

class IHttp implements HttpClient {
  final url = Uri.http("http://localhost:8000");
  get() {
    try {
      http.get(url);
    } catch (e) {}
  }

  post() {}
}
