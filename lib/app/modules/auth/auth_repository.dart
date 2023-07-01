import 'dart:io';

import 'package:dio/dio.dart';

import '../../core/services/intefaces/http_client.dart';
import 'erros/auth_erros.dart';

abstract class AuthRepository {
  Future<Response<dynamic>> login(String email, String password);
}

class AuthRepositoryImpl implements AuthRepository {
  final HttpClient _repository;
  AuthRepositoryImpl(this._repository);
  @override
  Future<Response<dynamic>> login(String email, String password) async {
    final data = <String, dynamic>{'email': email, 'password': password};
    try {
      final response = await _repository.post(
        '/auth/signin',
        Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
        data,
      );
      return response;
    } on DioError catch (e) {
      throw AuthErrorLogin(
        message: e.response?.data['msg'],
        statusCode: e.response?.statusCode ?? 0,
      );
    }
  }
}
