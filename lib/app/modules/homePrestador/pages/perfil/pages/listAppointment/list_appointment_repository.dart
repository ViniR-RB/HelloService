import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../../../core/db/db.dart';
import '../../../../../../core/services/intefaces/http_client.dart';

class ListAppointmentRepository {
  final HttpClient _repository;
  ListAppointmentRepository(this._repository);
  final DatabaseConnect db = DatabaseConnect();

  Future<Response<dynamic>> listAllAppointment() async {
    try {
      final user = await db.getUser();
      final token = user[0].webtoken;
      final id = user[0].id;
      final employeeid = {'employeeId': id};
      final response = await _repository.post(
        '/auth/signin/employee/myappointments',
        Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token'
          },
        ),
        employeeid,
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
