import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../../../core/services/intefaces/http_client.dart';
import 'erros/enterprise_erros.dart';

class EnterpriseRepository {
  HttpClient repository;
  EnterpriseRepository(this.repository);

  Future<Response> signInFactory(Map<String, dynamic> user) async {
    try {
      final response = await repository.post(
        '/auth/enterprise/signup',
        Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
        user,
      );
      return response;
    } on DioError catch (e) {
      throw EnterPriseErrorEmailAlreadyExisting(
        message: e.response!.data['msg'],
        statusCode: e.response!.statusCode ?? 0,
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
