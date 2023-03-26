import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class AuthRepository {
  Dio repository = Dio(BaseOptions(baseUrl: 'http://192.168.0.109:3001'));
  login(Map<String, dynamic> user) async {
    try {
      final Response<dynamic> response = await repository.post('/auth/signin',
          data: jsonEncode(user),
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          }));
      return response;
    } on DioError catch (e) {
      Exception(e);
    } catch (e) {
      Exception(e);
    }
  }
}
