import 'package:flutter_modular/flutter_modular.dart';

import 'accept_apointment_controller.dart';
import 'accept_apointment_repository.dart';
import 'pages/accept_apointment_page.dart';

class AcceptAppointmentModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => AcceptApointmentRepository(i.get())),
    Bind((i) => AcceptApointmentController(repository: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const AcceptAppointmentPage(),
    ),
  ];
}
