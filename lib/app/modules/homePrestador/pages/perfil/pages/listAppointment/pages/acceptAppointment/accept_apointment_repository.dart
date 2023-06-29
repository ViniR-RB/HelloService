import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../../../../../core/db/db.dart';
import '../../../../../../../../core/services/intefaces/http_client.dart';

class AcceptApointmentRepository {
  final HttpClient _repository;
  AcceptApointmentRepository(this._repository);
  final DatabaseConnect db = DatabaseConnect();

  Future<Response<dynamic>> agreeappointment(String appointmentId) async {
    try {
      final user = await db.getUser();
      final token = user[0].webtoken;
      final statusAgreed = {'status_agreed': 'inProgress'};
      final response = await _repository.post(
        '/auth/signin/$appointmentId/agreeappointment',
        Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token'
          },
        ),
        statusAgreed,
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
