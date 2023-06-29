import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../../../core/services/intefaces/http_client.dart';
import 'erros/employee_erros.dart';

class PeopleFormRepository {
  HttpClient repository;
  PeopleFormRepository(this.repository);

  Future<Response> signInPeople(Map<String, dynamic> user) async {
    try {
      final response = await repository.post(
        '/auth/employee/signup/',
        Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
        user,
      );
      return response;
    } on DioError catch (e) {
      throw EmployeeErrorEmailAlreadyExisting(
        message: e.response!.data['msg'],
        statusCode: e.response!.statusCode ?? 0,
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
