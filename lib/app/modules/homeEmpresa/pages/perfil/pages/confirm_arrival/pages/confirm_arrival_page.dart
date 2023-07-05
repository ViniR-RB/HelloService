import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../../../core/widgets/custom_app_bar.dart';
import '../confirm_arrival_controller.dart';

class ConfirmArrivalPage extends StatefulWidget {
  const ConfirmArrivalPage({super.key});

  @override
  State<ConfirmArrivalPage> createState() => _ConfirmArrivalPageState();
}

class _ConfirmArrivalPageState extends State<ConfirmArrivalPage> {
  var user = Modular.args.data;
  final ConfirmArrivalController _controller = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: Colors.black,
              child: const Center(
                child: Text(
                  'Confirme ou não a chegada do contratado',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              color: Colors.grey[800],
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _controller.confirmArrived('true');
                          Modular.to.pushNamed('/home/empresa/perfilempresa');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        child: const Text('Sim'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _controller.confirmArrived('false');
                          Modular.to.pushNamed('/home/empresa/perfilempresa');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                        child: const Text('Não'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
