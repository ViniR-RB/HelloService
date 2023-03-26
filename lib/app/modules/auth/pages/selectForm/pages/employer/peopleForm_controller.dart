import 'package:app/app/core/models/employer.dart';
import 'package:app/app/modules/auth/pages/selectForm/pages/employer/peopleForm_repository.dart';
import 'package:dio/dio.dart';

import '../../../../../../core/db/db.dart';
import '../../../../../../core/models/user.dart';

class PeopleFormController {
  final PeopleFormRepository repository;

  PeopleFormController({required this.repository});

  signInPeople(Map<String, dynamic> user) async {
    try {
      final Response<dynamic> response = await repository.signInPeople(user);
      final DatabaseConnect db = DatabaseConnect();
      final Map<String, dynamic> userData = response.data;
      final User users = Employer.fromMap(userData);
      print(users.type);
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
      throw Exception(e);
    }
  }
}
