import 'package:dio/dio.dart';

import 'home_repository.dart';

class HomeController {
  final HomeRepository repository;

  HomeController({required this.repository});

  Future<dynamic> listAllEmployeer() async {
    try {
      final Response<dynamic> response = await repository.listAllEmployeer();

      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
