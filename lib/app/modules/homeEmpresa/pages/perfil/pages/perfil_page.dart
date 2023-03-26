import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../../../../../core/db/db.dart';
import '../../../../../core/models/user.dart';

class PerfilEmpresaPage extends StatefulWidget {
  const PerfilEmpresaPage({super.key});

  @override
  State<PerfilEmpresaPage> createState() => _PerfilEmpresaPageState();
}

class _PerfilEmpresaPageState extends State<PerfilEmpresaPage> {
  final TextEditingController _statusController = TextEditingController();
  late DatabaseConnect db;
  late RxNotifier<User> user = RxNotifier<User>(
      User('0', 'name', 'token', '', '', password: 'password', email: 'email'));

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
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: _logout,
            child: Row(children: const [
              Icon(
                Icons.logout,
                color: Colors.black,
              ),
              Text('Deseja Fazer Logout?',
                  style: TextStyle(color: Colors.black)),
            ]),
          )
        ],
        backgroundColor: const Color.fromRGBO(249, 238, 47, 1),
        leading: Image.asset(
          'assets/logo/logo.png',
          scale: 1.5,
        ),
        title: const Text(
          'Meu Perfil',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'MavenPro',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
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
                  final DatabaseConnect db = DatabaseConnect();
                  final List<User> user = await db.getUser();
                  db.deleteToken(user[0].id);
                  Modular.to.navigate('/');
                },
              ),
            ],
          );
        });
  }

  _body() {
    return RxBuilder(builder: (_) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 14,
          ),
          CircleAvatar(
            maxRadius: 80,
            backgroundImage: NetworkImage(user.value.avatar == ''
                ? 'https://img.freepik.com/free-icon/important-person_318-10744.jpg?t=st=1645538552~exp=1645539152~hmac=268f4df1741112ca3b8735a233c8d50b8c76ebe5b0aa4d7bf90f1a359824ed8d&w=996'
                : user.value.avatar),
          ),
          const SizedBox(
            height: 52,
          ),
          _nome(user.value.username, 'Nome'),
          const SizedBox(
            height: 22,
          ),
          _solicatacoes()
        ],
      );
    });
  }

  _nome(String nome, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
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
                    fontFamily: 'MavenPro', fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 60.0),
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

  _status() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _statusDropDown(),
        ],
      ),
    );
  }

  _statusDropDown() {
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: Row(
        children: [
          Icon(
            size: 32,
            Icons.people,
            color: Colors.white,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
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
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Status'),
              onChanged: (status) {
                String _strStatus = status.toString();
                _statusController.text = _strStatus[0];
              },
              onSaved: (status) {
                String _strSexo = status.toString();
                _statusController.text = _strSexo[0];
                print(_statusController.text);
              },
            ),
          ),
        ],
      ),
    );
  }

  _solicatacoes() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
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
                'Veja Suas Solicitações',
                style: TextStyle(
                    fontFamily: 'MavenPro', fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
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
}
