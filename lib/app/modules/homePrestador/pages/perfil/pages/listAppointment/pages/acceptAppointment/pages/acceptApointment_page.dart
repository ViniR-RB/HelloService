import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../acceptApointment_controller.dart';

class AcceptAppointmentPage extends StatefulWidget {
  const AcceptAppointmentPage({super.key});

  @override
  State<AcceptAppointmentPage> createState() => _AcceptAppointmentPageState();
}

class _AcceptAppointmentPageState extends State<AcceptAppointmentPage> {
  var word = Modular.args.data;
  final AcceptApointmentController _controller = Modular.get();

  @override
  Widget build(BuildContext context) {
    final DateTime date =
        DateTime.parse('${word['appointment'][0]['expected_start']}');
    final data = DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt-Br').format(date);
    final hours =
        DateFormat(DateFormat.HOUR24_MINUTE_SECOND, 'pt-BR').format(date);
    return Scaffold(body: _body(data, hours));
  }

  _agreeappointment() async {
    try {
      _controller.agreeappointment(word['appointment'][0]['id']);
      final snackBar = SnackBar(
        content: const Text('Trabalho Aceito com Sucesso'),
        action: SnackBarAction(
          label: 'Continuar',
          onPressed: () {},
        ),
      );
      Modular.to.pop();
      return ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      final snackBar = SnackBar(
        content: const Text('Algum Erro Inesperado,tente novamente mais tarde'),
        action: SnackBarAction(
          label: 'Continuar',
          onPressed: () {
            return Modular.to.pop();
          },
        ),
      );
      return ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  _body(date, hours) {
    return Container(
        height: MediaQuery.of(context).size.height * .60,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(7, 7, 7, 1),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(80),
            bottomRight: Radius.circular(80),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
              child: GestureDetector(
                onTap: () => Modular.to.pop(),
                child: Row(children: const [
                  Icon(Icons.arrow_back),
                  SizedBox(
                    width: 12,
                  ),
                  Text('Solicitar', style: TextStyle(fontSize: 20))
                ]),
              ),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(word['enterprise'][0]['avatar']),
              radius: 50,
            ),
            const SizedBox(
              height: 12,
            ),
            _nomeTitle(),
            _emailTitle(),
            const SizedBox(
              height: 12,
            ),
            const Text('Horario do Trabalho Previsto:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Row(children: [
                    Icon(Icons.date_range),
                    Text('Dia: ${date.toString()}'),
                  ]),
                ),
                Container(
                  child: Row(children: [
                    Icon(Icons.access_time),
                    Text('Horário:$hours'),
                  ]),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _button(
                  'Voltar',
                  const Color.fromRGBO(54, 59, 107, 1),
                  () => Modular.to.pop(),
                ),
                const SizedBox(
                  width: 12,
                ),
                _button(
                  'Aceitar',
                  const Color.fromRGBO(20, 20, 20, 1),
                  _agreeappointment,
                )
              ],
            ),
          ],
        ));
  }

  _button(String label, Color? color, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Text(label,
              style: const TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }

  _nomeTitle() {
    return Text(
      '${word['enterprise'][0]['username']} está de Chamando',
      style: TextStyle(
          fontFamily: 'Raleway', fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  _emailTitle() {
    return Text(
      'Email: ${word['enterprise'][0]['email']}',
      style: TextStyle(
          fontFamily: 'Raleway', fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
