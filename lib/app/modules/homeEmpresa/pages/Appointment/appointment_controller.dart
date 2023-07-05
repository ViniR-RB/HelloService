import 'package:app/app/modules/homeEmpresa/pages/Appointment/appointment_repository.dart';

class AppointmentController {
  final AppointmentRepository repository;
  AppointmentController({required this.repository});

  Future createAppointment(
    String workType,
    String data,
    String hour,
    String minute,
    String employeerId,
  ) async {
    try {
      var response = await repository.createAppointment(
        workType,
        data,
        hour,
        minute,
        employeerId,
      );
      print('Dados enviados no controller: ${response.data}');
      return response.data;
    } catch (e) {
      print('Erro no controller createAppointment $e');
      throw Exception(e);
    }
  }

  Future<dynamic> getWork(String employeeid) async {
    try {
      final response = await repository.getWork(employeeid);
      print('Data ${response.data}');
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
