import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/db/db.dart';
import '../../../../core/services/intefaces/http_client.dart';

class EditEmployeeRepository {
  final HttpClient _repository;
  EditEmployeeRepository(this._repository);
  final DatabaseConnect db = DatabaseConnect();

  Future<Response<dynamic>> getUserEnterprise() async {
    final user = await db.getUser();
    final token = user[0].webtoken;
    try {
      final response = await _repository.get(
        '/auth/signin/prestador/home',
        Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token'
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response<dynamic>> putUserEnterprise(Map<String, dynamic> list) async {
    final data = list;
    try {
      final user = await db.getUser();
      final token = user[0].webtoken;
      final response = await _repository.put(
          '/auth/signin/enterprise/home',
          Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.authorizationHeader: 'Bearer $token'
            },
          ),
          data);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response<dynamic>> getAllWorks() async {
    try {
      final response = await _repository.get(
        '/admin/employee/list',
        Options(),
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
