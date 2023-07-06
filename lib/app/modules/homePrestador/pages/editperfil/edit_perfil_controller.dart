import 'edit_perfil_repository.dart';
import '../../../../core/db/db.dart';
import '../../../../core/services/intefaces/http_client.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class EditEmployeeController {
  final EditEmployeeRepository repository;

  EditEmployeeController({required this.repository});

  Future<dynamic> putUserEnterprise(Map<String, dynamic> list) async {
    try {
      final response = await repository.putUserEnterprise(list);

      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> getUser() async {
    try {
      final response = await repository.getAllWorks();
      final db = DatabaseConnect(); // Instância da classe do banco de dados
      final user = await db.getUser();
      final targetId = user[0].id;
      print(targetId);
      List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(
          response.data); // Converter para List<Map<String, dynamic>>

      List<Map<String, dynamic>> filteredList =
          dataList.where((item) => item['id'] == targetId).toList();
      print(filteredList);
      return filteredList;
    } catch (e) {
      throw Exception(e);
    }
  }
}
