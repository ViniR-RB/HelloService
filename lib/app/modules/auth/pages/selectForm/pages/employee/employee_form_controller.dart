import 'package:flutter/cupertino.dart';

import '../../../../../../core/db/db.dart';
import '../../../../../../core/models/employer.dart';
import '../../../../../../core/models/user.dart';
import '../../../../../../core/widgets/snackbar_custom.dart';
import 'employee_repository.dart';
import 'erros/employee_erros.dart';

class PeopleFormController {
  final PeopleFormRepository repository;

  PeopleFormController({required this.repository});

  Future<User?> signInPeople(
    Map<String, dynamic> user,
    BuildContext context,
  ) async {
    try {
      final response = await repository.signInPeople(user);
      final db = DatabaseConnect();
      final Map<String, dynamic> userData = response.data;
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
      return users;
    } on EmployeeErrorEmailAlreadyExisting catch (e) {
      CustomSnackBar(content: e.message, label: 'Continuar', onTap: () {})
          .showSnackBar();
      return null;
    }
  }
}
