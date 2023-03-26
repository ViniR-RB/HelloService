import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../../homePrestador/widgets/card.dart';
import '../home_controller.dart';

class HomeEmpresaPage extends StatefulWidget {
  const HomeEmpresaPage({Key? key}) : super(key: key);

  @override
  State<HomeEmpresaPage> createState() => _HomePageState();
}

class _HomePageState extends State<HomeEmpresaPage> {
  final HomeController _controller = Modular.get();
  RxNotifier<List<dynamic>> listaUser = RxNotifier([]);

  @override
  void initState() {
    super.initState();
    getEmployeers();
  }

  getEmployeers() {
    try {
      _controller.listAllEmployeer().then((value) => listaUser.value = value);
    } catch (e) {
      final snackBar = SnackBar(
        content: const Text('Token Inválido'),
        action: SnackBarAction(
          label: 'Continuar',
          onPressed: () {
            return Modular.to.navigate('/auth');
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  _appBar() {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () =>
                Modular.to.pushNamed('/home/empresa/perfilempresa'),
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ))
      ],
      backgroundColor: Color.fromRGBO(249, 238, 47, 1),
      leading: Image.asset(
        'assets/logo/logo.png',
        scale: 1.5,
      ),
      title: const Text(
        'HelloService',
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'MavenPro',
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
            child: const Text(
              'Lista de Funcionários Disponíveis',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          RxBuilder(
            builder: (context) {
              return listaUser.value.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                          itemCount: listaUser.value.length,
                          itemBuilder: (context, index) {
                            return Cardlist(
                              avatar: listaUser.value[index]['avatar'],
                              username: listaUser.value[index]['username'],
                              onTap: () => Modular.to.pushNamed(
                                  '/home/empresa/appointment/',
                                  arguments: listaUser.value[index]),
                            );
                          }),
                    );
            },
          )
        ],
      ),
    );
  }
}
