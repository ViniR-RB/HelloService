import 'dart:io';

import 'package:dio/dio.dart';

import '../../core/db/db.dart';
import '../../core/services/intefaces/http_client.dart';

class HomeRepository {
  final HttpClient _repository;
  HomeRepository(this._repository);
  final DatabaseConnect db = DatabaseConnect();

  Future<Response<dynamic>> addwork(String worktype) async {
    final user = await db.getUser();
    final token = user[0].webtoken.toString();
    final work = {'worktype': worktype};

    try {
      final response = await _repository.post(
        '/auth/signin/${user[0].id}/addwork',
        Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token'
          },
        ),
        work,
      );
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
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
