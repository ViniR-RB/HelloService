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
  List<dynamic> workList = [];
  late bool _isButtonsVisible = false;

  @override
  void initState() {
    super.initState();
    getEmployeers();
    getJobs();
  }

  Future<void> getJobs() async {
    try {
      workList = await _controller.getAllWorks();
    } catch (e) {
      if (mounted) {
        CustomSnackBar(
          content: 'Token Inválido',
          label: 'Continuar',
          onTap: () {
            return Modular.to.navigate('/auth');
          },
        ).showSnackBar();
      }
    }
  }

  getFilterWorks(String work) {
    try {
      _controller.filterWorks(work).then((value) => listaUser.value = value);
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

  getEmployeers() {
    try {
      _controller.listAllEmployeer().then((value) => listaUser.value = value);
      print(listaUser.value);
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
                SizedBox(height: 10.0),
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
                          labelText: 'Pesquise um usuário',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 63, 0, 209),
                                width: 1.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 193, 193, 193),
                                width: 2.0),
                          ),
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isButtonsVisible = !_isButtonsVisible;
                        });
                      },
                      icon: Icon(Icons.filter_alt_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Visibility(
            visible: _isButtonsVisible,
            child: SizedBox(
              height: 50, // Defina a altura desejada
              child: ListView.builder(
                scrollDirection: Axis
                    .horizontal, // Defina a direção do scroll como horizontal

                itemCount: workList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      getFilterWorks(workList[index]['work']);
                    },
                    child: Container(
                      width: 100,
                      height: 10, // Defina a largura desejada para cada botão
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(136, 237, 225, 225),
                            blurRadius: 4,
                            offset: Offset(0, 0.75),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.all(
                          8), // Adicione algum espaçamento entre os botões
                      child: Center(
                        child: Text(
                          workList[index]['work'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 10.0),
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
          ),
        ],
      ),
    );
  }
}
