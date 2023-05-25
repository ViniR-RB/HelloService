import 'package:flutter_modular/flutter_modular.dart';

import 'enterprise_controller.dart';
import 'enterprise_repository.dart';
import 'pages/enterprise_page.dart';

class EnterpriseModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => EnterpriseRepository(i.get())),
    Bind((i) => EnterpriseController(repository: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const EnterprisePage(),
    ),
  ];
}
