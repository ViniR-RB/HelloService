import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class EnterpriseRepository {
  Dio repository = Dio(BaseOptions(baseUrl: 'http://192.168.0.109:3001'));
  signInFactory(Map<String, dynamic> user) async {
    try {
      final Response<dynamic> response =
          await repository.post('/auth/enterprise/signup',
              data: jsonEncode(user),
              options: Options(headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
              }));
      print('Response:  $response');
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
