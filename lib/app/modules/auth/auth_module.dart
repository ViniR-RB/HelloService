import 'package:app/app/core/services/intefaces/http_client.dart';
import 'package:app/app/modules/auth/auth_controller.dart';
import 'package:app/app/modules/auth/auth_repository.dart';
import 'package:app/app/modules/auth/pages/auth_page.dart';
import 'package:app/app/modules/auth/pages/selectForm/selectForm_moudule.dart';
import 'package:app/app/modules/auth/pages/signin/signin_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind<AuthRepository>((i) => AuthRepositoryImpl(i.get<HttpClient>())),
    Bind<AuthController>((i) => AuthControllerImpl(repository: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const AuthPage()),
    ModuleRoute('/sigIn', module: SignInModule()),
    ModuleRoute('/selectform', module: SelectFormModule()),
  ];
}
