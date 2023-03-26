import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../../../../../widgets/card.dart';
import '../listAppointment_controller.dart';

class ListAppointmentPage extends StatefulWidget {
  const ListAppointmentPage({super.key});

  @override
  State<ListAppointmentPage> createState() => _ListAppointmentPageState();
}

class _ListAppointmentPageState extends State<ListAppointmentPage> {
  final ListAppointmentController _controller = Modular.get();
  RxNotifier<dynamic> appointmentList = RxNotifier([]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listAllAppointment();
  }

  listAllAppointment() async {
    appointmentList.value = await _controller.listAllAppointment();
  }

  @override
  Widget build(BuildContext context) {
    print(appointmentList.value);
    return RxBuilder(
      builder: (context) {
        return Scaffold(
            appBar: AppBar(title: const Text('Solicitações')), body: _body());
      },
    );
  }

  _body() {
    return RxBuilder(
      builder: (context) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.builder(
                  itemCount: appointmentList.value.length,
                  itemBuilder: (context, index) {
                    return Cardlist(
                      avatar: appointmentList.value[index]['enterprise'][0]
                          ['avatar'],
                      username: appointmentList.value[index]['enterprise'][0]
                          ['username'],
                      onTap: () => Modular.to.pushNamed(
                          '/home/prestador/perfil/listppointment/acceptappointment/',
                          arguments: appointmentList.value[index]),
                    );
                  }),
            ),
          ],
        );
      },
    );
  }
}
