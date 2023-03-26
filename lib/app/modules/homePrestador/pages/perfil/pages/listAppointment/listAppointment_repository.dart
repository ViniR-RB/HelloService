import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../../../core/db/db.dart';

class ListAppointmentRepository {
  Dio repository = Dio(BaseOptions(baseUrl: 'http://192.168.0.109:3001'));
  final DatabaseConnect db = DatabaseConnect();

  Future<Response<dynamic>> listAllAppointment() async {
    try {
      final user = await db.getUser();
      final String token = user[0].webtoken.toString();
      final String id = user[0].id;
      final employeeid = {'employeeId': id};
      final Response<dynamic> response = await repository.post(
        '/auth/signin/employee/myappointments',
        data: jsonEncode(employeeid),
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
