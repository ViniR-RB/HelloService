import 'package:flutter_modular/flutter_modular.dart';

import 'pages/confirm_arrival/confirm_arrivel_module.dart';
import 'pages/perfil_page.dart';

class PerfilEmpresaModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const PerfilEmpresaPage()),
    ModuleRoute('/confirm_arrival', module: ConfirmArrivalModule()),
  ];
}
