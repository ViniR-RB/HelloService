import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/db/db.dart';
import '../../../core/models/user.dart';

class SplashPage extends StatefulWidget {
  SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool teste = true;
  final DatabaseConnect db = DatabaseConnect();
  validarToken() async {
    final List<User> userList = await db.getUser();
    if (userList.isEmpty) {
      final Future<Set<void>> duration = Future.delayed(
          const Duration(seconds: 2),
          () => {
                Modular.to.navigate('/auth/'),
              });
    } else if (userList[0].type == 'employee') {
      var duration = Future.delayed(
          const Duration(seconds: 2),
          () => {
                Modular.to.navigate('/home/prestador/'),
              });
    } else {
      var duration = Future.delayed(
        const Duration(seconds: 2),
        () => Modular.to.navigate('/home/empresa/'),
      );
    }
  }

  @override
  void initState() {
    validarToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(249, 238, 47, 1), body: _body());
  }

  _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Center(child: Image.asset('assets/logo/logo.png'))],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
