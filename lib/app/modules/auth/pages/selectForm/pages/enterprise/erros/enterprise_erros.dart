// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class EnterPriseError implements Exception {}

class EnterPriseErrorEmailAlreadyExisting extends EnterPriseError {
  final String message;
  final int statusCode;
  EnterPriseErrorEmailAlreadyExisting({
    required this.message,
    required this.statusCode,
  });
}
