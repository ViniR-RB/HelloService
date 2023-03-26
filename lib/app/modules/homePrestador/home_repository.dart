import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../core/db/db.dart';
import '../../core/models/user.dart';

class HomeRepository {
  Dio repository = Dio(BaseOptions(baseUrl: 'http://192.168.0.109:3001'));
  final DatabaseConnect db = DatabaseConnect();

  Future<Response<dynamic>> addwork(String worktype) async {
    final List<User> user = await db.getUser();
    final String token = user[0].webtoken.toString();
    final work = {'worktype': worktype};

    try {
      final Response<dynamic> response = await repository.post(
        '/auth/signin/${user[0].id}/addwork',
        data: jsonEncode(work),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        }),
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
      final Response<dynamic> response = await repository.get(
        '/auth/signin/employee/allworks',
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
