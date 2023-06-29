import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/db/db.dart';
import '../../../core/utils/namedRoutes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool teste = true;
  final DatabaseConnect db = DatabaseConnect();
  validarToken() async {
    final userList = await db.getUser();
    if (userList.isEmpty) {
      final duration = Future<Set<void>>.delayed(
        const Duration(seconds: 2),
        () => {
          Modular.to.navigate('/auth/'),
        },
      );
    } else if (userList[0].type == 'enterprise') {
      Modular.to.navigate(NamedRoutes.homeEmpresa);
    } else if (userList[0].type == 'employer') {
      final duration = Future.delayed(
        const Duration(seconds: 2),
        () => {Modular.to.navigate(NamedRoutes.homePrestador)},
      );
    } else {
      final duration = Future.delayed(
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
      backgroundColor: const Color.fromRGBO(249, 238, 47, 1),
      body: _body(),
    );
  }

  Column _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Center(child: Image.asset('assets/logo/logo.png'))],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
