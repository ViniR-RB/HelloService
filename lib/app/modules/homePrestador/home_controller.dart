import 'package:app/app/modules/homePrestador/home_repository.dart';

class HomeController {
  final HomeRepository repository;
  HomeController({required this.repository});

  addwork(String worktype) async {
    try {
      final response = await repository.addwork(worktype);
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> getAllWorks() async {
    try {
      final response = await repository.getAllWorks();
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
