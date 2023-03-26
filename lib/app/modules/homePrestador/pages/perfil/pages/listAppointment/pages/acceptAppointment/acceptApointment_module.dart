import 'package:flutter_modular/flutter_modular.dart';

import 'acceptApointment_controller.dart';
import 'acceptApointment_repository.dart';
import 'pages/acceptApointment_page.dart';

class AcceptAppointmentModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => AcceptApointmentRepository()),
    Bind((i) => AcceptApointmentController(repository: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const AcceptAppointmentPage()),
  ];
}
