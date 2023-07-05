import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../../../core/db/db.dart';
import '../../../../../../core/services/intefaces/http_client.dart';

class ConfirmArrivalRepository {
  final HttpClient _repository;

  ConfirmArrivalRepository(this._repository);
  final DatabaseConnect db = DatabaseConnect();

  Future<Response<dynamic>> getAppointment() async {
    try {
      final user = await db.getUser();
      final token = user[0].webtoken;
      final perfType = user[0].type;
      final enterpriseId = user[0].id;
      final dataBody = {
        'appointmentId': enterpriseId,
        'perfType': perfType,
      };
      var url = '/auth/signin/getappointment/';
      final response = await _repository.post(
        url,
        Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token'
          },
        ),
        dataBody,
      );
      print('Response da função getAppointment $response');
      return response;
    } catch (e) {
      print('O Erro na função getAppointment foi ==> $e');
      throw Exception(e);
    }
  }

  Future<Response<dynamic>> confirmArrived(
    String isArrived,
  ) async {
    try {
      final user = await db.getUser();
      final token = user[0].webtoken;
      final perfType = user[0].type;
      Response<dynamic> finalAppointment = await getAppointment();
      List<dynamic> appointmentList = finalAppointment.data;
      String appointmentId = appointmentList[0]['id'];

      final dataBody = {'isArrived': isArrived};
      var url = '/auth/signin/$appointmentId/$perfType/arrivedConfirm';
      final response = await _repository.post(
        url,
        Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token'
          },
        ),
        dataBody,
      );
      print('Response da função confirmArrived $response');
      return response;
    } catch (e) {
      print('O Erro na função confirmArrived foi ==> $e');
      throw Exception(e);
    }
  }
}
