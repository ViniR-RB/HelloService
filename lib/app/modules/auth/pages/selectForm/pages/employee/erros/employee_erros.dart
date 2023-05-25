// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class EmployeeError implements Exception {}

class EmployeeErrorEmailAlreadyExisting extends EmployeeError {
  final String message;
  final int statusCode;
  EmployeeErrorEmailAlreadyExisting({
    required this.message,
    required this.statusCode,
  });
}
