import 'dart:convert';

class User {
  final String id;
  final String username;
  final String password;
  final String email;
  final String webtoken;
  final String avatar;
  final String type;

  User(
    this.id,
    this.username,
    this.webtoken,
    this.avatar,
    this.type, {
    required this.password,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'webtoken': webtoken,
      'type': type,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
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

  String toJson() => json.encode(toMap());
}
