import 'confirm_arrival_repository.dart';

class ConfirmArrivalController {
  final ConfirmArrivalRepository repository;
  ConfirmArrivalController({required this.repository});

  Future confirmArrived(
    String isArrived,
  ) async {
    try {
      var response = await repository.confirmArrived(isArrived);
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
