import 'package:app/app/core/models/user.dart';

class Employer extends User {
  Employer(super.id, super.username, super.webtoken, super.avatar, super.type,
      {required super.password, required super.email});
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'webtoken': webtoken,
      'type': type,
    };
  }

  factory Employer.fromMap(Map<String, dynamic> map) {
    return Employer(
      map['employee']['id'] ?? '',
      map['employee']['username'] ?? '',
      map['webtoken'] ?? '',
      map['employee']['avatar'] ??
          'https://img.freepik.com/free-icon/important-person_318-10744.jpg?t=st=1645538552~exp=1645539152~hmac=268f4df1741112ca3b8735a233c8d50b8c76ebe5b0aa4d7bf90f1a359824ed8d&w=996',
      map['employee']['type'] ?? 'employee',
      email: map['employee']['email'] ?? '',
      password: map['employee']['password'] ?? '',
    );
  }
}
