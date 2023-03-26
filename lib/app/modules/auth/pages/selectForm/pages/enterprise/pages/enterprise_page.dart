import 'package:app/app/modules/auth/pages/selectForm/pages/enterprise/enterprise_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EnterprisePage extends StatefulWidget {
  const EnterprisePage({Key? key}) : super(key: key);

  @override
  State<EnterprisePage> createState() => _FormFactoryPageState();
}

class _FormFactoryPageState extends State<EnterprisePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usenameController = TextEditingController();

  final TextEditingController _firstnameController = TextEditingController();

  final TextEditingController _lastnameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _telefoneController = TextEditingController();

  final TextEditingController _cnpjController = TextEditingController();

  // final TextEditingController _dtnascimentoController = TextEditingController();

  // final TextEditingController _sexoController = TextEditingController();

  final TextEditingController _cepController = TextEditingController();

  final TextEditingController _estadoController = TextEditingController();

  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _descripitionController = TextEditingController();
  final EnterpriseController _controller = Modular.get();
  void validatedForm() async {
    if (_formKey.currentState!.validate()) {
      final snackBar = SnackBar(
        content: const Text('Email inválido, tente outro'),
        action: SnackBarAction(
          label: 'Continuar',
          onPressed: () {},
        ),
      );
      Map<String, dynamic> user = {
        'username': _usenameController.text,
        'first_name': _firstnameController.text,
        // 'last_name': _lastnameController.text,
        'password': _passwordController.text,
        'phone_number': _telefoneController.text,
        'email': _emailController.text,
        'avatar':
            'https://img.freepik.com/free-icon/important-person_318-10744.jpg?t=st=1645538552~exp=1645539152~hmac=268f4df1741112ca3b8735a233c8d50b8c76ebe5b0aa4d7bf90f1a359824ed8d&w=996',
        'description': _descripitionController.text,
        'zip_code': _cepController.text,
        'state': _estadoController.text,
        'cyte': _cidadeController.text,
        'cnpj': _cnpjController.text,
      };
      try {
        final Response<dynamic> response =
            await _controller.signInFactory(user);
        Modular.to.navigate('/home/empresa');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Container(
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
                    child: Container(
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.only(top: 100)),
                          Text(
                            'Conte Nós Mais Sobre Sua Empresa',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(54, 59, 107, 1),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                              child: ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Form(
                                          key: _formKey,
                                          child: Column(
                                            children: [
                                              _fields('User Name:', 'User Name',
                                                  _usenameController),
                                              _fields(
                                                  'Primeiro Nome:',
                                                  'Matheus',
                                                  _firstnameController),
                                              // _fields('Segundo Nome:', 'Levi',
                                              //     _lastnameController),
                                              _fields('Email', 'a@a.com.br',
                                                  _emailController),
                                              _fields('Senha', '@dsahu3214',
                                                  _passwordController),
                                              _fields(
                                                  'Celular (com DD):',
                                                  '00 00000-0000',
                                                  _telefoneController),
                                              _fields('Cep:', '00000-000',
                                                  _cepController),
                                              _fields('Estado:', 'Piaui',
                                                  _estadoController),
                                              _fields('Cidade:', 'Teresina',
                                                  _cidadeController),
                                              _fields(
                                                  'CNPJ:',
                                                  'XX.XXX.XXX/0001-XX',
                                                  _cnpjController),
                                              _fields(
                                                  'Descrição:',
                                                  'Focado, Determinando',
                                                  _descripitionController),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  button(
                                                    'Confirmar',
                                                    () => validatedForm(),
                                                  ),
                                                  button('Voltar',
                                                      () => Modular.to.pop()),
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

  button(String label, Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 16, bottom: 12),
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: TextStyle(color: Color.fromRGBO(54, 59, 107, 1)),
          side: BorderSide.none,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          backgroundColor: Color.fromRGBO(249, 238, 47, 1),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }

  field(
    size,
    String? Function(String?)? validator,
    controller,
    label,
    hintText,
    textInputType,
  ) {
    return Container(
      color: Color.fromRGBO(48, 48, 48, 1),
      height: size.height / 14,
      width: size.width / 1.2,
      child: TextFormField(
        validator: validator,
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.grey),
          label: Text(label),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          border: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(48, 48, 48, 1), width: 1),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(48, 48, 48, 1), width: 1),
          ),
        ),
      ),
    );
  }

  _fields(String title, label, TextEditingController controller) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(left: 22.0, top: 12)),
            Text(
              '$title',
              style: TextStyle(
                fontFamily: 'MavenPro',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 12.0, bottom: 0)),
        field(
          MediaQuery.of(context).size,
          (p0) => null,
          controller,
          '$label',
          '$label',
          TextInputType.name,
        ),
      ],
    );
  }
}
