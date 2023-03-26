import 'package:app/app/modules/homePrestador/home_controller.dart';
import 'package:app/app/modules/homePrestador/home_repository.dart';
import 'package:app/app/modules/homePrestador/pages/perfil/perfil_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'pages/home_page.dart';

class HomePrestadorModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => HomeRepository()),
    Bind((i) => HomeController(repository: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const HomePrestadorPage()),
    ModuleRoute('/perfil', module: PerfilModule()),
  ];
}
