import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../../../../../core/widgets/snackbar_custom.dart';
import '../appointment_controller.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  var word = Modular.args.data;
  RxNotifier<bool> checked = RxNotifier(false);
  RxNotifier<List<dynamic>> work_provider = RxNotifier([]);
  final TextEditingController _worktypeController = TextEditingController();
  RxNotifier<String> datapt = RxNotifier('');
  RxNotifier<String> hour = RxNotifier('');
  RxNotifier<String> minute = RxNotifier('');
  RxNotifier<DateTime> date = RxNotifier(DateTime.now());
  final AppointmentController _controller = Modular.get();

  @override
  void initState() {
    super.initState();
    /* getWork(); */
  }

/*   getWork() async {
    try {
      work_provider.value = await _controller.getWork(word['id']);
    } catch (e) {
      throw Exception(e);
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body());
  }

  void _sendAppointment() {
    if (_worktypeController.text.isEmpty ||
        hour.value.isEmpty ||
        minute.value.isEmpty) {
      CustomSnackBar(
        content: 'Preencha os Dados que estão faltando',
        label: 'Continuar',
        onTap: () {},
      ).showSnackBar();
    } else {
      try {
        _controller.createAppointment(
          _worktypeController.text,
          date.value.toString(),
          hour.value,
          minute.value,
          word['id'],
        );
        CustomSnackBar(
          content: 'Contrato Criado',
          label: 'Continuar',
          onTap: () {},
        ).showSnackBar();
        Modular.to.pop();
      } catch (e) {
        CustomSnackBar(
          content: 'Algum erro inesperado',
          label: 'Continuar',
          onTap: () {},
        ).showSnackBar();
      }
    }
  }

  RxBuilder _body() {
    return RxBuilder(
      builder: (context) {
        return Container(
          height: work_provider.value.isEmpty
              ? MediaQuery.of(context).size.height * .60
              : MediaQuery.of(context).size.height * .80,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: GestureDetector(
                  onTap: () => Modular.to.pop(),
                  child: Row(
                    children: const [
                      Icon(Icons.arrow_back),
                      SizedBox(
                        width: 12,
                      ),
                      Text('Solicitar', style: TextStyle(fontSize: 20))
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(word['avatar']),
                radius: 50,
              ),
              const SizedBox(
                height: 12,
              ),
              _nomeTitle(),
              _emailTitle(),
              const SizedBox(
                height: 30,
              ),
              const Text('Esse Usuario Fornece esses serviços'),
              const Text('Escolha Apenas Um!'),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 80,
                child: work_provider.value.isEmpty
                    ? const Text('Esse Usuario Não Pode Ser Chamado')
                    : workTypeDropdown(),
              ),
              if (work_provider.value.isEmpty)
                Container()
              else
                const Text('Horario de Inicio'),
              if (work_provider.value.isEmpty)
                Container()
              else
                Row(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.date_range),
                            onPressed: () async {
                              final data = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2022),
                                lastDate: DateTime(2023),
                                locale: Localizations.localeOf(context),
                              );
                              if (data != null) {
                                datapt.value = DateFormat(
                                  DateFormat.YEAR_MONTH_DAY,
                                  'pt-Br',
                                ).format(data);
                                date.value = data;
                              }
                            },
                          ),
                          Text(datapt.value)
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.access_time),
                            onPressed: () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (time != null) {
                                if (time.hour == 0 ||
                                    time.hour == 1 ||
                                    time.hour == 2 ||
                                    time.hour == 3 ||
                                    time.hour == 4 ||
                                    time.hour == 5 ||
                                    time.hour == 6 ||
                                    time.hour == 7 ||
                                    time.hour == 8 ||
                                    time.hour == 9) {
                                  hour.value = '0${time.hour.toString()}';
                                } else {
                                  hour.value = time.hour.toString();
                                }
                                if (time.minute == 0 ||
                                    time.minute == 1 ||
                                    time.minute == 2 ||
                                    time.minute == 3 ||
                                    time.minute == 4 ||
                                    time.minute == 5 ||
                                    time.minute == 6 ||
                                    time.minute == 7 ||
                                    time.minute == 8 ||
                                    time.minute == 9) {
                                  minute.value = '0${time.minute.toString()}';
                                } else {
                                  minute.value = time.minute.toString();
                                }
                              }
                            },
                          ),
                          Text('${hour.value}:${minute.value}')
                        ],
                      ),
                    )
                  ],
                ),
              if (work_provider.value.isEmpty)
                Container()
              else
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
                      'Enviar',
                      const Color.fromRGBO(20, 20, 20, 1),
                      _sendAppointment,
                    )
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  GestureDetector _button(String label, Color? color, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget workTypeDropdown() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: DropdownButtonFormField(
        iconSize: 32,
        hint: Text(
          _worktypeController.text,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        items: word['work'].value.map((name) {
          return DropdownMenuItem<dynamic>(
            value: name,
            child: Text(
              name['profession'],
              style: Theme.of(context).textTheme.titleSmall,
            ),
          );
        }).toList(),
        decoration: const InputDecoration(labelText: 'Trabalho'),
        onChanged: (profession) {
          _worktypeController.text = profession.toString();
        },
        onSaved: (profession) {
          _worktypeController.text = profession.toString();
        },
      ),
    );
  }

  Text _nomeTitle() {
    return Text(
      word['username'],
      style: const TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text _emailTitle() {
    return Text(
      'Email: ${word['email']}',
      style: const TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
