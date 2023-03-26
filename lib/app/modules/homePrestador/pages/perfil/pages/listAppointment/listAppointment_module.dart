import 'package:app/app/modules/homePrestador/pages/perfil/pages/listAppointment/listAppointment_repository.dart';
import 'package:app/app/modules/homePrestador/pages/perfil/pages/listAppointment/pages/acceptAppointment/acceptApointment_module.dart';
import 'package:app/app/modules/homePrestador/pages/perfil/pages/listAppointment/pages/listAppointment_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'listAppointment_controller.dart';

class ListAppointmentModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => ListAppointmentRepository()),
    Bind((i) => ListAppointmentController(repository: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const ListAppointmentPage()),
    ModuleRoute('/acceptappointment', module: AcceptAppointmentModule()),
  ];
}
