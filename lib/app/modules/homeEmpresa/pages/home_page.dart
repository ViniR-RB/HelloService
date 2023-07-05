import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/snackbar_custom.dart';
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
      final snackBar = CustomSnackBar(
        content: 'Token Inválido',
        label: 'Continuar',
        onTap: () {
          return Modular.to.navigate('/auth');
        },
      ).showSnackBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        actions: [
          IconButton(
            onPressed: () =>
                Modular.to.pushNamed('/home/empresa/perfilempresa'),
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: _body(),
    );
  }

  String filtro = '';

  SingleChildScrollView _body() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 12, 10, 30),
            child: Column(
              children: [
                const Text(
                  'Lista de Funcionários Disponíveis',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
               
                
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            filtro = value.toLowerCase();
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Digite um filtro',
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          filtro = '';
                        });
                      },
                      icon: Icon(Icons.clear),
                    ),
                  ],
                ),

                
              ],
            ),
          ),
          RxBuilder(
            builder: (context) {
              return listaUser.value.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: listaUser.value.length,
                        itemBuilder: (context, index) {
                          final user = listaUser.value[index];
                          final username = user['first_name'].toLowerCase();

                          if (filtro.isNotEmpty && !username.contains(filtro)) {
                            return SizedBox
                                .shrink(); // Ignora o item se não corresponder ao filtro
                          }
                          return Cardlist(
                            avatar: listaUser.value[index]['avatar'],
                            username: listaUser.value[index]['first_name'],
                            onTap: () => Modular.to.pushNamed(
                              '/home/empresa/appointment/',
                              arguments: listaUser.value[index],
                            ),
                          );
                        },
                      ),
                    );
            },
          )
        ],
      ),
    );
  }
}
