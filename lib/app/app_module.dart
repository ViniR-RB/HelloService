import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/services/implements/http_client_impl.dart';
import 'core/services/intefaces/http_client.dart';
import 'core/utils/configurate.dart';
import 'core/utils/namedRoutes.dart';
import 'modules/auth/auth_module.dart';
import 'modules/homeEmpresa/home_module.dart';
import 'modules/homePrestador/home_module.dart';
import 'modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => Dio(BaseOptions(baseUrl: ConfigurateEnv.baseUrl)),
    ),
    Bind.singleton<HttpClient>((i) => DioHttp(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(NamedRoutes.initial, module: SplashModule()),
    ModuleRoute(NamedRoutes.auth, module: AuthModule()),
    ModuleRoute(NamedRoutes.homeEmpresa, module: HomeEmpresaModule()),
    ModuleRoute(NamedRoutes.homePrestador, module: HomePrestadorModule()),
  ];
}
