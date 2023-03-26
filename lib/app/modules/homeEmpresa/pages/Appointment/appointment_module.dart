import 'package:flutter_modular/flutter_modular.dart';

import 'appointment_controller.dart';
import 'appointment_repository.dart';
import 'pages/appointment_page.dart';

class AppointmentModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => AppointmentRepository()),
    Bind((i) => AppointmentController(repository: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const AppointmentPage()),
    // ModuleRoute('/perfilempresa', module: PerfilEmpresaModule()),
  ];
}
