import 'package:app/app/core/db/db.dart';
import 'package:app/app/core/models/employer.dart';
import 'package:app/app/core/models/enterprise.dart';
import 'package:app/app/core/models/user.dart';
import 'package:app/app/modules/auth/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';

abstract class AuthController {
  Future login(String email, String password);
}

class AuthControllerImpl implements AuthController {
  final AuthRepository repository;

  AuthControllerImpl({required this.repository});

  @override
  Future login(String email, String password) async {
    try {
      final db = DatabaseConnect();
      final response = await repository.login(email, password);

      var isClient = false;
      final Map<String, dynamic> userData = response.data;

      if (userData['user Type'] == 'enterprise') {
        final User users = Enterprise.fromMap(userData);
        final userList = await db.getUser();

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

        final userList = await db.getUser();

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
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
