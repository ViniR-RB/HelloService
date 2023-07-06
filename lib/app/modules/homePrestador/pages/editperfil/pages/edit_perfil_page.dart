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
  late Map<String, dynamic> userData = {};

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _usenameController = TextEditingController();

  final TextEditingController _firstnameController = TextEditingController();

  final TextEditingController _lastnameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  late TextEditingController _emailController = TextEditingController();

  final TextEditingController _telefoneController = TextEditingController();

  final TextEditingController _cpfController = TextEditingController();

  final TextEditingController _cepController = TextEditingController();

  final TextEditingController _estadoController = TextEditingController();

  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _descripitionController = TextEditingController();

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
// Obtém o ID do usuário
      userData = await _controller.getUser();
      print(userData);
      //List<Map<String, dynamic>> filteredList =
      //  await userData.where((item) => item['id'] == id).toList();
      setState(() {
        userData = userData;
        _usenameController = TextEditingController(text: userData['username']);
        _emailController = TextEditingController(text: userData['email']);

        '''        
        _firstnameController.text = userData['first_name'];
        _lastnameController.text = userData['last_name'];
        _passwordController.text = userData['password'];
        _emailController.text = userData['email'];
        _telefoneController.text = userData['phone_number'];
        _cpfController.text = userData['cpf'];
        _cepController.text = userData['zip_code'];
        _estadoController.text = userData['state'];
        _cidadeController.text = userData['city'];
        _descripitionController.text = userData['description'];''';
      });
      // Realize as operações necessárias com a lista filtrada aqui...
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
    getUserData();
    db = DatabaseConnect();
    print(userData);

    db.getUser().then((value) {
      setState(() {
        user.value = value[0];

        //_usenameController.text = user.value.username;
        //_firstnameController.text = user.value.firstName;

        //_lastnameController.text = user.value.lastName;
        //_passwordController.text = user.value.password;
        // _emailController.text = user.value.email;
        //   _telefoneController.text = user.value.phoneNumber;
        // _cpfController.text = user.value.cnpj;
        //_cepController.text = user.value.zipCode;
        //_estadoController.text = user.value.state;
        //_cidadeController.text = user.value.city;
        //_descripitionController.text = user.value.description;
      });
    });
  }

  @override
  void dispose() {
    _usenameController.dispose();
    super.dispose();
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
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            _fields(
                                              'User Name:',
                                              'User Name',
                                              _usenameController,
                                            ),
                                            _fields(
                                              'Primeiro Nome:',
                                              'Matheus',
                                              _firstnameController,
                                            ),
                                            // _fields('Segundo Nome:', 'Levi',
                                            //     _lastnameController),
                                            Text(
                                              'Longitude: ${_emailController}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'NeonTubes2',
                                                color: Colors.white,
                                              ),
                                            ),
                                            _fields(
                                              'Email',
                                              _emailController,
                                              _emailController,
                                            ),
                                            _fields(
                                              'Senha',
                                              '@dsahu3214',
                                              _passwordController,
                                            ),
                                            _fields(
                                              'Celular (com DD):',
                                              _telefoneController,
                                              _telefoneController,
                                            ),
                                            _fields(
                                              'Cep:',
                                              '00000-000',
                                              _cepController,
                                            ),
                                            _fields(
                                              'Estado:',
                                              'Piaui',
                                              _estadoController,
                                            ),
                                            _fields(
                                              'Cidade:',
                                              'Teresina',
                                              _cidadeController,
                                            ),
                                            _fields(
                                              'CNPJ:',
                                              userData['cpf'],
                                              _cpfController,
                                            ),
                                            _fields(
                                              'Descrição:',
                                              'Focado, Determinando',
                                              _descripitionController,
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
