import 'package:flutter/material.dart';

import '../../core/db/db.dart';
import '../../core/models/employer.dart';
import '../../core/models/enterprise.dart';
import '../../core/models/user.dart';
import '../../core/widgets/snackbar_custom.dart';
import 'auth_repository.dart';
import 'erros/auth_erros.dart';

abstract class AuthController {
  Future<User?> login(String email, String password, BuildContext context);
}

class AuthControllerImpl implements AuthController {
  final AuthRepository repository;

  AuthControllerImpl({required this.repository});

  @override
  Future<User?> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final response = await repository.login(email, password);

      final Map<String, dynamic> userData = response.data;

      final db = DatabaseConnect();

      if (userData['user_type'] == 'enterprise') {
        final User user = Enterprise.fromMap(userData);
        final userList = await db.getUser();

        if (userList.isNotEmpty) {
          await db.deleteToken(userList[0].id);
          await db.insertUser(user);
        } else {
          await db.insertUser(user);
        }

        return user;
      } else {
        final User user = Employer.fromMap(userData);

        final userList = await db.getUser();
        if (userList.isNotEmpty) {
          await db.deleteToken(userList[0].id);
          await db.insertUser(user);
        } else {
          await db.insertUser(user);
        }
        return user;
      }
    } on AuthErrorLogin catch (e) {
      CustomSnackBar(content: e.message, label: 'Continuar', onTap: () {})
          .showSnackBar();
      return null;
    }
  }
}
