import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/db/db.dart';
import '../../../../core/services/intefaces/http_client.dart';

class AppointmentRepository {
  final HttpClient _repository;
  AppointmentRepository(this._repository);
  final DatabaseConnect db = DatabaseConnect();

  Future<Response<dynamic>> createAppointment(
    String workType,
    String data,
    String hour,
    String minute,
    String employeerId,
  ) async {
    final user = await db.getUser();
    final token = user[0].webtoken;
    final id = user[0].id;
    final date = data.split(' ');
    print(date);
    final appointment = {
      'employeeId': employeerId,
      'worktype': workType,
      'expected_start': '${date[0]}T$hour:$minute:00',
      'expected_end': '${date[0]}T$hour:$minute:00'
    };
    try {
      final response = await _repository.post(
        '/auth/signin/enterprise/$id/home/hire',
        Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token'
          },
        ),
        appointment,
      );
      return response;
    } on DioError catch (error) {
      throw Exception(error.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response<dynamic>> getWork(String employeeid) async {
    try {
      final user = await db.getUser();
      final token = user[0].webtoken;

      final map = <String, dynamic>{'employeeid': employeeid};
      final response = _repository.post(
        '/auth/signin/enterprise/home/employeeview',
        Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token'
          },
        ),
        map,
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
