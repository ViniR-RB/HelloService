import 'package:flutter_modular/flutter_modular.dart';

import '../../core/services/intefaces/http_client.dart';
import 'auth_controller.dart';
import 'auth_repository.dart';
import 'pages/auth_page.dart';
import 'pages/selectForm/selectForm_moudule.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind<AuthRepository>((i) => AuthRepositoryImpl(i.get<HttpClient>())),
    Bind<AuthController>((i) => AuthControllerImpl(repository: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const AuthPage()),
    ModuleRoute('/selectform', module: SelectFormModule()),
  ];
}
