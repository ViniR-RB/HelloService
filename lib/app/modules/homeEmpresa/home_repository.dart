import 'dart:io';

import 'package:app/app/core/db/db.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  Dio repository = Dio(BaseOptions(baseUrl: 'http://192.168.0.109:3001'));
  final DatabaseConnect db = DatabaseConnect();

  Future<Response<dynamic>> listAllEmployeer() async {
    final user = await db.getUser();
    final String token = user[0].webtoken.toString();
    try {
      final Response<dynamic> response = await repository.get(
        '/auth/signin/enterprise/home/listalllemployeers',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        }),
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
