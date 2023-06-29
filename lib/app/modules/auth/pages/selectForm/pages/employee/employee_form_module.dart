import 'package:flutter_modular/flutter_modular.dart';

import 'employee_form_controller.dart';
import 'employee_repository.dart';
import 'pages/employee_page.dart';

class FormPeopleModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => PeopleFormRepository(i.get())),
    Bind((i) => PeopleFormController(repository: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const FormPeoplePage(),
    ),
  ];
}
