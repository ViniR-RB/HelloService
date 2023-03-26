import 'package:app/app/modules/auth/pages/signin/pages/sigin_page.dart';
import 'package:app/app/modules/auth/pages/signin/signi_controller.dart';
import 'package:app/app/modules/auth/pages/signin/signi_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignInModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => SignInRepository()),
    Bind((i) => SignInController(repository: i.get())),
  ];
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => SignInPage()),
  ];
}
