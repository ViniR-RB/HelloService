import 'package:app/app/core/db/db.dart';
import 'package:app/app/core/models/employer.dart';
import 'package:app/app/core/models/enterprise.dart';
import 'package:app/app/core/models/user.dart';
import 'package:app/app/modules/auth/auth_repository.dart';
import 'package:dio/dio.dart';

class AuthController {
  final AuthRepository repository;

  AuthController({required this.repository});

  login(Map<String, dynamic> user) async {
    try {
      final DatabaseConnect db = DatabaseConnect();
      final Response<dynamic> response = await repository.login(user);

      bool isClient = false;
      final Map<String, dynamic> userData = response.data;

      if (userData['user Type'] == 'enterprise') {
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

        return isClient;
      } else {
        isClient = true;
        final User users = Employer.fromMap(userData);

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

        return isClient;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
