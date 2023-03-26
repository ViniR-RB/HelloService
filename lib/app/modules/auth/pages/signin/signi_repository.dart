import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class SignInRepository {
  Dio repository = Dio();
  var url = 'http://172.17.0.1:3000/users/createUser';
  signIn(name, email, password) async {
    try {
      final Map<String, dynamic> login = {
        'name': name,
        'email': email,
        'password': password,
      };
      var response = await repository.post(url,
          data: jsonEncode(login),
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          }));
      print('Response: $response');
      return response;
    } catch (e) {
      return 409;
    }
  }
}
