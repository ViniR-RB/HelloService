import 'package:app/app/core/services/intefaces/auth_service.dart';

import '../intefaces/http_client.dart';

class Authentication implements AuthService {
  final HttpClient _auth;
  Authentication({required this._auth});
  signIn(String email, String password) {}
}
