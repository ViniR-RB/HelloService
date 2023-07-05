import 'dart:io';

import 'package:dio/dio.dart';

import '../../core/db/db.dart';
import '../../core/services/intefaces/http_client.dart';

class HomeRepository {
  final HttpClient _repository;
  HomeRepository(this._repository);
  final DatabaseConnect db = DatabaseConnect();

  Future<Response<dynamic>> filterWorks(String work) async {
    final user = await db.getUser();
    final token = user[0].webtoken;
    final data = {'name_work': work};

    try {
      final response = await _repository.post(
          '/auth/signin/enterprise/home/filter_work_employess',
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

  Future<Response<dynamic>> listAllEmployeer() async {
    final user = await db.getUser();
    final token = user[0].webtoken;
    try {
      final response = await _repository.get(
        '/auth/signin/enterprise/home',
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

  Future<Response<dynamic>> getAllWorks() async {
    try {
      final response = await _repository.get(
        '/admin/worktype/all',
        Options(),
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
