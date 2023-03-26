import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../../../../../core/db/db.dart';

class AcceptApointmentRepository {
  Dio repository = Dio(BaseOptions(baseUrl: 'http://192.168.0.109:3001'));
  final DatabaseConnect db = DatabaseConnect();

  Future<Response<dynamic>> agreeappointment(String appointmentId) async {
    try {
      final user = await db.getUser();
      final String token = user[0].webtoken.toString();
      final status_agreed = {'status_agreed': 'inProgress'};
      final response = await repository.post(
        data: jsonEncode(status_agreed),
        '/auth/signin/$appointmentId/agreeappointment',
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
