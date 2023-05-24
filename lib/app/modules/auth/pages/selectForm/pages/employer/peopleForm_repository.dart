import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class PeopleFormRepository {
  Dio repository = Dio(BaseOptions(baseUrl: 'http://10.30.54.148:3001'));
  Future<Response> signInPeople(Map<String, dynamic> user) async {
    try {
      final response = await repository.post(
        '/auth/employee/signup/',
        data: jsonEncode(user),
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );
      print('Response:  $response');
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
