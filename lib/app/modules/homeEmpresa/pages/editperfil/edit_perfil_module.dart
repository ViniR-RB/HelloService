import 'package:flutter_modular/flutter_modular.dart';

import 'edit_perfil_controller.dart';
import 'edit_perfil_repository.dart';
import 'pages/edit_perfil_page.dart';

class EditEnterpriseModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => EditRepository(i.get())),
    Bind((i) => EditController(repository: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const EditEnterprisePage()),
  ];
}
