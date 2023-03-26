import 'package:dio/dio.dart';

import 'listAppointment_repository.dart';

class ListAppointmentController {
  final ListAppointmentRepository repository;

  ListAppointmentController({required this.repository});

  Future<dynamic> listAllAppointment() async {
    try {
      final Response<dynamic> response = await repository.listAllAppointment();
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
