import 'package:flutter_modular/flutter_modular.dart';

import 'modules/auth/auth_module.dart';
import 'modules/homeEmpresa/home_module.dart';
import 'modules/homePrestador/home_module.dart';
import 'modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: SplashModule()),
    ModuleRoute('/auth', module: AuthModule()),
    ModuleRoute('/home/empresa', module: HomeEmpresaModule()),
    ModuleRoute('/home/prestador', module: HomePrestadorModule()),
  ];
}
