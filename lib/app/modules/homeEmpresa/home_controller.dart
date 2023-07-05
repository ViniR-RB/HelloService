import 'home_repository.dart';

class HomeController {
  final HomeRepository repository;

  HomeController({required this.repository});

  Future<dynamic> listAllEmployeer() async {
    try {
      final response = await repository.listAllEmployeer();

      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> filterWorks(String work) async {
    try {
      final response = await repository.filterWorks(work);
      print(response.data[0]['employees']);
      return response.data[0]['employees'];
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
