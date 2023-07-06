import 'edit_perfil_repository.dart';

class EditController {
  final EditRepository repository;

  EditController({required this.repository});

  Future<dynamic> putUserEnterprise(Map<String, dynamic> list) async {
    try {
      final response = await repository.putUserEnterprise(list);

      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> getUserEnterprisse() async {
    try {
      final response = await repository.getUserEnterprise();
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> getUser() async {
    try {
      final response = await repository.getAllWorks();
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
