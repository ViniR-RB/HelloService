import 'package:app/app/modules/auth/pages/selectForm/pages/enterprise/enterprise_module.dart';
import 'package:app/app/modules/auth/pages/selectForm/pages/enterprise/pages/enterprise_page.dart';
import 'package:app/app/modules/auth/pages/selectForm/pages/employer/pages/peopleForm_page.dart';
import 'package:app/app/modules/auth/pages/selectForm/pages/employer/peopleForm_module.dart';

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
