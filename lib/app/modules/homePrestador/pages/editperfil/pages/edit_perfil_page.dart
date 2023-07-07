import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../core/models/user.dart';
import '../../../../../core/db/db.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../../../../../core/widgets/snackbar_custom.dart';
import '../edit_perfil_controller.dart';

class EditEmployeePage extends StatefulWidget {
  const EditEmployeePage({Key? key}) : super(key: key);

  @override
  State<EditEmployeePage> createState() => _FormFactoryPageState();
}

class _FormFactoryPageState extends State<EditEmployeePage> {
  final EditEmployeeController _controller = Modular.get();
  late List<Map<String, dynamic>> userData;

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _usenameController = TextEditingController();

  late TextEditingController _firstnameController = TextEditingController();

  late TextEditingController _lastnameController = TextEditingController();

  late TextEditingController _passwordController = TextEditingController();

  late TextEditingController _emailController = TextEditingController();

  late TextEditingController _telefoneController = TextEditingController();

  late TextEditingController _cpfController = TextEditingController();

  late TextEditingController _cepController = TextEditingController();

  late TextEditingController _estadoController = TextEditingController();

  late TextEditingController _cidadeController = TextEditingController();
  late TextEditingController _descripitionController = TextEditingController();

  late DatabaseConnect db;

  late RxNotifier<User> user = RxNotifier<User>(
    User('0', 'name', 'token', '', '', password: 'password', email: 'email'),
  );

  Future<void> validatedForm() async {
    if (_formKey.currentState!.validate()) {
      final snackBar = SnackBar(
        content: const Text('Email inválido, tente outro'),
        action: SnackBarAction(
          label: 'Continuar',
          onPressed: () {},
        ),
      );
      final user = <String, dynamic>{
        'username': _usenameController.value.text,
        'first_name': _firstnameController.text,
        'last_name': _lastnameController.text,
        'password': _passwordController.value.text,
        'phone_number': _telefoneController.value.text,
        'email': _emailController.value.text,
        'avatar':
            'https://img.freepik.com/free-icon/important-person_318-10744.jpg?t=st=1645538552~exp=1645539152~hmac=268f4df1741112ca3b8735a233c8d50b8c76ebe5b0aa4d7bf90f1a359824ed8d&w=996',
        'description': _descripitionController.value.text,
        'zip_code': _cepController.value.text,
        'state': _estadoController.value.text,
        'cyte': _cidadeController.value.text,
        'cpf': _cpfController.value.text,
      };

      final response = await _controller.putUserEnterprise(user);

      if (response != null) {
        Modular.to.navigate('/home/prestador');
      }
    }
  }

  Future<void> getUserData() async {
    try {
      userData = await _controller.getUser();
      print('test');
      print(userData);
      setState(() {
        _firstnameController.text = userData[0]['first_name'].toString();
        _lastnameController.text = userData[0]['last_name'].toString();
        _passwordController.text = userData[0]['password'].toString();
        _emailController.text = userData[0]['email'].toString();
        _telefoneController.text = userData[0]['phone_number'].toString();
        _cpfController.text = userData[0]['cpf'].toString();
        _cepController.text = userData[0]['zip_code'].toString();
        _estadoController.text = userData[0]['state'].toString();
        _cidadeController.text = userData[0]['city'].toString();
        _descripitionController.text = userData[0]['description'].toString();
      });

      //return userData;
      // Realize as operações necessárias com os dados do usuário aqui...
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

  @override
  void initState() {
    super.initState();
    db = DatabaseConnect();
    getUserData();
    db.getUser().then((value) {
      setState(() {
        user.value = value[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
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
              ],
            ),
          )
        ],
        backgroundColor: const Color.fromRGBO(249, 238, 47, 1),
      ),
      body: _body(),
    );
  }

  SingleChildScrollView _body() {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 1,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        const Text(
                          'Edite seu perfil',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.zero,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(54, 59, 107, 1),
                              borderRadius: BorderRadius.zero,
                            ),
                            child: ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Column(
                                    children: [
                                      Form(
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: _firstnameController,
                                              decoration: InputDecoration(
                                                labelText: 'First Name',
                                              ),
                                            ),
                                            TextFormField(
                                              controller: _lastnameController,
                                              decoration: InputDecoration(
                                                labelText: 'Last Name',
                                              ),
                                            ),
                                      
                                            TextFormField(
                                              controller: _emailController,
                                              decoration: InputDecoration(
                                                labelText: 'Email',
                                              ),
                                            ),
                                            TextFormField(
                                              controller: _telefoneController,
                                              decoration: InputDecoration(
                                                labelText: 'Phone Number',
                                              ),
                                            ),
                                            TextFormField(
                                              controller: _cpfController,
                                              decoration: InputDecoration(
                                                labelText: 'CPF',
                                              ),
                                            ),
                                            TextFormField(
                                              controller: _cepController,
                                              decoration: InputDecoration(
                                                labelText: 'CEP',
                                              ),
                                            ),
                                            TextFormField(
                                              controller: _estadoController,
                                              decoration: InputDecoration(
                                                labelText: 'Estado',
                                              ),
                                            ),
                                            TextFormField(
                                              controller: _cidadeController,
                                              decoration: InputDecoration(
                                                labelText: 'City',
                                              ),
                                            ),
                                            TextFormField(
                                              controller:
                                                  _descripitionController,
                                              decoration: InputDecoration(
                                                labelText: 'Description',
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                button(
                                                  'Confirmar',
                                                  validatedForm,
                                                ),
                                                button(
                                                  'Voltar',
                                                  () => Modular.to.pop(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding button(String label, Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 16, bottom: 12),
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(color: Color.fromRGBO(54, 59, 107, 1)),
          side: BorderSide.none,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          backgroundColor: const Color.fromRGBO(249, 238, 47, 1),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }

  Container field(
    size,
    controller,
    label,
    hintText,
    textInputType,
  ) {
    return Container(
      color: const Color.fromRGBO(48, 48, 48, 1),
      height: size.height / 14,
      width: size.width / 1.2,
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.grey),
          label: Text(label),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(48, 48, 48, 1)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(48, 48, 48, 1)),
          ),
        ),
      ),
    );
  }

  Column _fields(String title, label, TextEditingController controller) {
    return Column(
      children: [
        Row(
          children: [
            const Padding(padding: EdgeInsets.only(left: 22, top: 12)),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'MavenPro',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 12)),
        field(
          MediaQuery.of(context).size,
          controller,
          '$label',
          '$label',
          TextInputType.name,
        ),
      ],
    );
  }
}
