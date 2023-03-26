import 'package:dio/dio.dart';

import 'acceptApointment_repository.dart';

class AcceptApointmentController {
  final AcceptApointmentRepository repository;
  AcceptApointmentController({required this.repository});

  agreeappointment(String appointmentId) async {
    try {
      final Response<dynamic> response =
          await repository.agreeappointment(appointmentId);
    } catch (e) {
      throw Exception(e);
    }
  }
}
