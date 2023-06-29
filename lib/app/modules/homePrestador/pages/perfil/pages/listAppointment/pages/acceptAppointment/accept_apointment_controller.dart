import 'accept_apointment_repository.dart';

class AcceptApointmentController {
  final AcceptApointmentRepository repository;
  AcceptApointmentController({required this.repository});

  Future<void> agreeappointment(String appointmentId) async {
    try {
      await repository.agreeappointment(appointmentId);
    } catch (e) {
      throw Exception(e);
    }
  }
}
