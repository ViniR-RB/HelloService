import 'package:flutter_modular/flutter_modular.dart';

import 'home_controller.dart';
import 'home_repository.dart';
import 'pages/Appointment/appointment_module.dart';
import 'pages/home_page.dart';
import 'pages/perfil/perfil_module.dart';

class HomeEmpresaModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => HomeRepository(i.get())),
    Bind((i) => HomeController(repository: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const HomeEmpresaPage(),
    ),
    ModuleRoute('/perfilempresa', module: PerfilEmpresaModule()),
    ModuleRoute('/appointment', module: AppointmentModule()),
  ];
}
