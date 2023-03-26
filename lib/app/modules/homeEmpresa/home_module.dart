import 'package:app/app/modules/homeEmpresa/pages/Appointment/appointment_module.dart';
import 'package:app/app/modules/homeEmpresa/pages/perfil/perfil_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_controller.dart';
import 'home_repository.dart';
import 'pages/home_page.dart';

class HomeEmpresaModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => HomeRepository()),
    Bind((i) => HomeController(repository: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const HomeEmpresaPage()),
    ModuleRoute('/perfilempresa', module: PerfilEmpresaModule()),
    ModuleRoute('/appointment', module: AppointmentModule()),
  ];
}
