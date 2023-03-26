import 'package:app/app/modules/homeEmpresa/pages/Appointment/appointment_repository.dart';
import 'package:dio/dio.dart';

class AppointmentController {
  final AppointmentRepository repository;
  AppointmentController({required this.repository});

  createAppointment(String workType, String data, String hour, String minute,
      String employeerId) async {
    try {
      Response<dynamic> response = await repository.createAppointment(
          workType, data, hour, minute, employeerId);
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> getWork(String employeeid) async {
    try {
      final Response<dynamic> response = await repository.getWork(employeeid);
      print('Data ${response.data}');
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
