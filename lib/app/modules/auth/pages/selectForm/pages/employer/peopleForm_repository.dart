import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class PeopleFormRepository {
  Dio repository = Dio(BaseOptions(baseUrl: 'http://192.168.0.109:3001'));
  signInPeople(Map<String, dynamic> user) async {
    try {
      final Response<dynamic> response =
          await repository.post('/auth/employee/signup/',
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
