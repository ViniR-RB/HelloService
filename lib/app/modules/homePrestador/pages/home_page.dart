import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/snackbar_custom.dart';
import '../home_controller.dart';

class HomePrestadorPage extends StatefulWidget {
  const HomePrestadorPage({Key? key}) : super(key: key);

  @override
  State<HomePrestadorPage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePrestadorPage> {
  RxNotifier<List<dynamic>> workList = RxNotifier([]);
  final HomeController _controller = Modular.get();

  @override
  void initState() {
    super.initState();
    getEmployeers();
  }

  Future<void> getEmployeers() async {
    try {
      workList.value = await _controller.getAllWorks();
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

  Future<void> selectWork(String worktype) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Deseja Ser $worktype?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Não'),
              onPressed: () {
                Modular.to.pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Sim,Quero'),
              onPressed: () {
                _controller.addwork(worktype);
                Modular.to.pop();
                CustomSnackBar(
                  content: 'Trabalho Adicionado com Sucesso',
                  label: 'Continuar',
                  onTap: () {},
                ).showSnackBar();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBarCustom(
        actions: [
          IconButton(
            onPressed: () => Modular.to.pushNamed('/home/prestador/perfil/'),
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
          )
        ],
        backgroundColor: const Color.fromRGBO(249, 238, 47, 1),
        leading: Image.asset(
          'assets/logo/logo.png',
          scale: 1.5,
        ),
      ),
      body: _body(height, width),
    );
  }

  SingleChildScrollView _body(double height, double width) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
            child: const Text(
              'Lista de Serviços Que Podem Ser Prestados',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          RxBuilder(
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(8),
                height: height * 0.8,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                    maxCrossAxisExtent: height * 0.3,
                    mainAxisExtent: height * .22,
                  ),
                  itemCount: workList.value.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () =>
                          selectWork('${workList.value[index]['work']}'),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.8,
                          decoration: const BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 4,
                                offset: Offset(0, 0.75),
                              ),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.indigo,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  workList.value[index]['work'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Preço:R\$ ${workList.value[index]['price']}',
                                )
                              ],
                            ),
                          ),
                        ),
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
