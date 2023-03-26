import 'package:app/app/modules/auth/pages/selectForm/pages/employer/peopleForm_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FormPeoplePage extends StatefulWidget {
  const FormPeoplePage({Key? key}) : super(key: key);

  @override
  State<FormPeoplePage> createState() => _FormPeoplePageState();
}

class _FormPeoplePageState extends State<FormPeoplePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstnameController = TextEditingController();

  final TextEditingController _lastnameController = TextEditingController();

  final TextEditingController _usenameController = TextEditingController();

  final TextEditingController _descripitionController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _telefoneController = TextEditingController();

  final TextEditingController _cpfController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _sexoController = TextEditingController();

  final TextEditingController _cepController = TextEditingController();

  final TextEditingController _estadoController = TextEditingController();

  final TextEditingController _cidadeController = TextEditingController();

  final PeopleFormController _controller = Modular.get();

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
      try {
        final dynamic response = await _controller.signInPeople(user);
        // isnew = false;
        // isnew
        // ? Modular.to.navigate('/home/')
        // : Modular.to.navigate('/auth/selectform');

        Modular.to.navigate('/home/prestador');
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: _body(size),
    );
  }

  _body(size) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.all(24)),
          _title('Finalize seu cadastro'),
          Form(
            key: _formKey,
            child: Column(
              children: [
                _field(size, _usenameController, 'User Name'),
                _field(size, _firstnameController, 'Primeiro Nome'),
                _field(size, _lastnameController, 'Segundo Nome'),
                _field(size, _emailController, 'Email'),
                _field(size, _passwordController, 'Password'),
                _field(size, _telefoneController, 'Telefone'),
                _field(size, _cpfController, 'CPF'),
                _field(size, _cepController, 'Cep'),
                _field(size, _estadoController, 'Estado'),
                _field(size, _cidadeController, 'Cidade'),
                _field(size, _descripitionController, 'Descrição')
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buttonFinish(size, () => validatedForm(), 'Finalizar'),
              SizedBox(
                width: 20,
              ),
              _buttonFinish(size, () => Modular.to.pop('/selectform'), 'Voltar')
            ],
          )
        ],
      ),
    );
  }

  _field(Size size, TextEditingController controller, labelText) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.red,
          labelText: labelText,
          border: const UnderlineInputBorder(),
          labelStyle: const TextStyle(
            fontFamily: 'Raleway',
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _title(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
              fontSize: 36),
        ),
      ],
    );
  }

  _buttonFinish(Size size, onpressed, label) {
    return Container(
      width: size.width / 2.5,
      child: TextButton(
        onPressed: onpressed,
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
          ),
        ),
        style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            side: BorderSide(
              color: Color.fromRGBO(82, 163, 208, 1),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
