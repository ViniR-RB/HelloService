import 'package:app/app/modules/homePrestador/pages/perfil/pages/listAppointment/list_appointment_repository.dart';
import 'package:app/app/modules/homePrestador/pages/perfil/pages/listAppointment/pages/acceptAppointment/accept_apointment_module.dart';
import 'package:app/app/modules/homePrestador/pages/perfil/pages/listAppointment/pages/list_appointment_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'list_appointment_controller.dart';

class ListAppointmentModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => ListAppointmentRepository(i.get())),
    Bind((i) => ListAppointmentController(repository: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const ListAppointmentPage(),
    ),
    ModuleRoute('/acceptappointment', module: AcceptAppointmentModule()),
  ];
}
