// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class AuthError implements Exception {}

class AuthErrorLogin implements AuthError {
  final String message;
  final int statusCode;
  AuthErrorLogin({
    required this.message,
    required this.statusCode,
  });
}
