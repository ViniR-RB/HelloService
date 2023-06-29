import 'package:app/app/modules/auth/pages/selectForm/pages/enterprise/enterprise_module.dart';
import 'package:app/app/modules/auth/pages/selectForm/pages/enterprise/pages/enterprise_page.dart';
import 'package:app/app/modules/auth/pages/selectForm/pages/employee/pages/employee_page.dart';
import 'package:app/app/modules/auth/pages/selectForm/pages/employee/employee_form_module.dart';

import 'package:app/app/modules/auth/pages/selectForm/pages/selectForm_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

class SelectFormModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => SelectFormPage()),
    ModuleRoute('/empresa', module: EnterpriseModule()),
    ModuleRoute('/prestador', module: FormPeopleModule()),
  ];
}
