import 'package:flutter/material.dart';

import '../../../../../../core/db/db.dart';
import '../../../../../../core/models/enterprise.dart';
import '../../../../../../core/models/user.dart';
import '../../../../../../core/widgets/snackbar_custom.dart';
import 'enterprise_repository.dart';
import 'erros/enterprise_erros.dart';

class EnterpriseController {
  final EnterpriseRepository repository;

  EnterpriseController({required this.repository});

  Future<User?> signInEnterprise(
    Map<String, dynamic> user,
    BuildContext context,
  ) async {
    try {
      final response = await repository.signInFactory(user);
      final db = DatabaseConnect();
      final Map<String, dynamic> userData = response.data;
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
      return users;
    } on EnterPriseErrorEmailAlreadyExisting catch (e) {
      ShowSnackBarError(content: e.message, label: 'Continuar', onTap: () {})
          .showSnackBar(context);
    }
    return null;
  }
}
