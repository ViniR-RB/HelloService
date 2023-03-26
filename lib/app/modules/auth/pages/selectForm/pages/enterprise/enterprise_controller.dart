import 'package:app/app/core/models/enterprise.dart';
import 'package:dio/dio.dart';

import '../../../../../../core/db/db.dart';
import '../../../../../../core/models/user.dart';
import 'enterprise_repository.dart';

class EnterpriseController {
  final EnterpriseRepository repository;

  EnterpriseController({required this.repository});

  signInFactory(Map<String, dynamic> user) async {
    try {
      final Response<dynamic> response = await repository.signInFactory(user);
      final DatabaseConnect db = DatabaseConnect();
      final Map<String, dynamic> userData = response.data;
      final User users = Enterprise.fromMap(userData);
      final List<User> userList = await db.getUser();

      if (userList.isEmpty) {
        await db.insertUser(users);
      } else {
        if (users.id != userList[0].id) {
          await db.deleteToken(userList[0].id);
          await db.insertUser(users);
        } else {
          await db.deleteToken(users.id);
          await db.insertUser(users);
        }
      }
      return response;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
