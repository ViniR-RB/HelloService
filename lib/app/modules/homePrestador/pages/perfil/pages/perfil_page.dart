import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../../../../../core/db/db.dart';
import '../../../../../core/models/user.dart';
import '../../../../../core/widgets/custom_app_bar.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final TextEditingController _statusController = TextEditingController();
  late DatabaseConnect db;
  late RxNotifier<User> user = RxNotifier<User>(
    User('0', 'name', 'token', '', '', password: 'password', email: 'email'),
  );

  @override
  void initState() {
    db = DatabaseConnect();
    db.getUser().then((value) => {user.value = value[0]});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(32, 32, 32, 1),
      appBar: AppBarCustom(
        actions: [
          GestureDetector(
            onTap: _logout,
            child: Row(
              children: const [
                Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                Text(
                  'Logout?',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  width: 12,
                )
              ],
            ),
          )
        ],
        backgroundColor: const Color.fromRGBO(249, 238, 47, 1),
        leading: Image.asset(
          'assets/logo/logo.png',
          scale: 1.5,
        ),
      ),
      body: _body(),
    );
  }

  Future<void> _logout() {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Deseja Sair?'),
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
              onPressed: () async {
                final db = DatabaseConnect();
                final user = await db.getUser();
                await db.deleteToken(user[0].id);
                Modular.to.navigate('/');
              },
            ),
          ],
        );
      },
    );
  }

  RxBuilder _body() {
    return RxBuilder(
      builder: (_) {
        return Column(
          children: [
            const SizedBox(
              height: 14,
            ),
            CircleAvatar(
              maxRadius: 80,
              backgroundImage: NetworkImage(
                user.value.avatar == ''
                    ? 'https://img.freepik.com/free-icon/important-person_318-10744.jpg?t=st=1645538552~exp=1645539152~hmac=268f4df1741112ca3b8735a233c8d50b8c76ebe5b0aa4d7bf90f1a359824ed8d&w=996'
                    : user.value.avatar,
              ),
            ),
            const SizedBox(
              height: 52,
            ),
            _nome(user.value.username, 'Nome'),
            const SizedBox(
              height: 22,
            ),
            _nome('Disponível', 'Status'),
            const SizedBox(
              height: 22,
            ),
            _solicatacoes()
          ],
        );
      },
    );
  }

  Container _nome(String nome, String label) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              size: 32,
              Icons.people,
              color: Colors.grey,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style:
                    const TextStyle(fontFamily: 'MavenPro', color: Colors.grey),
              ),
              Text(
                nome,
                style: const TextStyle(
                  fontFamily: 'MavenPro',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 60),
            child: Icon(
              Icons.keyboard_arrow_right,
              size: 30,
              color: Color.fromRGBO(82, 163, 208, 1),
            ),
          ),
        ],
      ),
    );
  }

  Container _status() {
    return Container(
      child: Row(
        children: [
          _statusDropDown(),
        ],
      ),
    );
  }

  Padding _statusDropDown() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        children: [
          const Icon(
            size: 32,
            Icons.people,
            color: Colors.white,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: DropdownButtonFormField(
              iconSize: 32,
              hint: Text(
                _statusController.text,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              items: ['Disponivel', 'Indisponível'].map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(
                    status,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Status'),
              onChanged: (status) {
                final _strStatus = status.toString();
                _statusController.text = _strStatus[0];
              },
              onSaved: (status) {
                final _strSexo = status.toString();
                _statusController.text = _strSexo[0];
                print(_statusController.text);
              },
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector _solicatacoes() {
    return GestureDetector(
      onTap: () =>
          Modular.to.pushNamed('/home/prestador/perfil/listppointment/'),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                size: 32,
                Icons.phone_outlined,
                color: Colors.white,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Solicitações',
                  style: TextStyle(fontFamily: 'MavenPro', color: Colors.grey),
                ),
                Text(
                  'Veja suas\nSolicitações',
                  style: TextStyle(
                    fontFamily: 'MavenPro',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 60),
              child: Icon(
                Icons.keyboard_arrow_right,
                size: 30,
                color: Color.fromRGBO(82, 163, 208, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
