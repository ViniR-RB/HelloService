import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/db/db.dart';

class AppointmentRepository {
  Dio repository = Dio(BaseOptions(baseUrl: 'http://192.168.0.109:3001'));
  final DatabaseConnect db = DatabaseConnect();

  Future<Response<dynamic>> createAppointment(String workType, String data,
      String hour, String minute, String employeerId) async {
    final user = await db.getUser();
    final String token = user[0].webtoken.toString();
    final String id = user[0].id;
    final date = data.split(' ');
    print(date);
    final appointment = {
      'employeeId': employeerId,
      "worktype": workType,
      "expected_start": "${date[0]}T$hour:$minute:00",
      "expected_end": "${date[0]}T$hour:$minute:00"
    };
    try {
      final Response<dynamic> response = await repository.post(
        '/auth/signin/enterprise/$id/home/hire',
        data: jsonEncode(appointment),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        }),
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
      final String token = user[0].webtoken.toString();

      final map = {"employeeid": employeeid};
      final response = repository.post(
        '/auth/signin/enterprise/home/employeeview',
        data: jsonEncode(map),
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
