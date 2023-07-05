import 'package:flutter_modular/flutter_modular.dart';

import 'confirm_arrival_controller.dart';
import 'confirm_arrival_repository.dart';
import 'pages/confirm_arrival_page.dart';

class ConfirmArrivalModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => ConfirmArrivalRepository(i.get())),
    Bind((i) => ConfirmArrivalController(repository: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const ConfirmArrivalPage(),
    ),
  ];
}
