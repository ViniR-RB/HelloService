import 'package:dio/dio.dart';

abstract class HttpClient {
  Future<Response<dynamic>> get(String url, Options? options);
  Future<Response<dynamic>> post(
      String url, Options? options, Map<String, dynamic> data);
}
