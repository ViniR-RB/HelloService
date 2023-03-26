import 'package:app/app/modules/auth/pages/selectForm/pages/enterprise/enterprise_controller.dart';
import 'package:app/app/modules/auth/pages/selectForm/pages/enterprise/pages/enterprise_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'enterprise_repository.dart';

class EnterpriseModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => EnterpriseRepository()),
    Bind((i) => EnterpriseController(repository: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const EnterprisePage()),
  ];
}
