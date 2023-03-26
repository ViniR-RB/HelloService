import 'package:app/app/core/services/intefaces/http_client.dart';
import 'package:get_it/get_it.dart';

import 'implements/auth_service.dart';
import 'implements/http_client.dart';
import 'intefaces/auth_service.dart';

final locator = GetIt.instance;

void setupDependecies() {
  locator.registerLazySingleton<HttpClient>(() => IHttp());
  locator
      .registerLazySingleton<AuthService>(() => Authentication(_auth: IHttp()));
}
