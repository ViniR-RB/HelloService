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
//gambiarra monstra aqui para extrarir o nome do tipo de trabalho:
    String workTypeFull = workType;

// Remover os caracteres '{' e '}' da string
    String cleanString = workTypeFull.replaceAll('{', '').replaceAll('}', '');

// Dividir a string em pares de chave-valor
    List<String> keyValuePairs = cleanString.split(', ');

// Procurar o par chave-valor contendo "work:"
    String workPair =
        keyValuePairs.firstWhere((pair) => pair.contains("work:"));

// Extrair o valor após "work:"
    String workValue = workPair.substring(workPair.indexOf("work:") + 6);

// Remover espaços em branco extras
    String trimmedWorkValue = workValue.trim();

// Atribuir o valor extraído à variável dataworkType
    final dataworkType = trimmedWorkValue;

    print(dataworkType); // Saída: motoboy

    final appointment = {
      'employeeId': employeerId,
      'worktype': dataworkType,
      'expected_start': '${date[0]}',
      'expected_end': '${date[0]}'
    };
    print('Workype: ${appointment['worktype']}');
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
      print('Response do repositorio createAppointment ${response}');
      return response;
    } on DioError catch (error) {
      print('Erro do dioerror: ${error.message}');
      throw Exception(error.message);
    } catch (e) {
      print('Erro do repositorio: $e');
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
