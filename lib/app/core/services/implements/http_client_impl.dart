import 'dart:convert';

import 'package:app/app/core/services/intefaces/http_client.dart';
import 'package:dio/dio.dart';

class DioHttp implements HttpClient {
  final Dio _dio;
  DioHttp(this._dio);

  @override
  Future<Response<dynamic>> get(String url, Options? options) async {
    final response = await _dio.get(url, options: options);
    return response;
  }

  @override
  Future<Response> post(
    String url,
    Options? options,
    Map<String, dynamic> data,
  ) async {
    final response =
        await _dio.post(url, options: options, data: jsonEncode(data));

    return response;
  }

  @override
  Future<Response> put(
    String url,
    Options? options,
    Map<String, dynamic> data,
  ) async {
    final response =
        await _dio.put(url, options: options, data: jsonEncode(data));

    return response;
  }
}
