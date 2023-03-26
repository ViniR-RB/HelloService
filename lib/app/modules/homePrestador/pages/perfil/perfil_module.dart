import 'package:app/app/modules/homePrestador/pages/perfil/pages/listAppointment/listAppointment_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'pages/perfil_page.dart';

class PerfilModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const PerfilPage()),
    ModuleRoute('/listppointment', module: ListAppointmentModule()),
  ];
}
