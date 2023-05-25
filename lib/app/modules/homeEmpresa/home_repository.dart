import 'dart:io';

import 'package:dio/dio.dart';

import '../../core/db/db.dart';

class HomeRepository {
  Dio repository;
  HomeRepository(this.repository);
  final DatabaseConnect db = DatabaseConnect();

  Future<Response<dynamic>> listAllEmployeer() async {
    final user = await db.getUser();
    final token = user[0].webtoken.toString();
    try {
      final response = await repository.get(
        '/admin/worktype/all',
        options: Options(
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
}
