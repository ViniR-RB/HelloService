import 'package:app/app/core/models/user.dart';

class Enterprise extends User {
  Enterprise(super.id, super.username, super.webtoken, super.avatar, super.type,
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

  factory Enterprise.fromMap(Map<String, dynamic> map) {
    return Enterprise(
      map['enterprise']['id'] ?? '',
      map['enterprise']['username'] ?? '',
      map['webtoken'] ?? '',
      map['enterprise']['avatar'] ??
          'https://img.freepik.com/free-icon/important-person_318-10744.jpg?t=st=1645538552~exp=1645539152~hmac=268f4df1741112ca3b8735a233c8d50b8c76ebe5b0aa4d7bf90f1a359824ed8d&w=996',
      map['enterprise']['type'] ?? 'enterprise',
      email: map['enterprise']['email'] ?? '',
      password: map['enterprise']['password'] ?? '',
    );
  }
}
