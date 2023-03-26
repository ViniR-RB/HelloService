import 'package:app/app/modules/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/utils/validator.dart';
import '../../../core/widgets/snackbar_custom.dart';
import '../widgets/auth_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  // bool isnew = true;

  final _formKey = GlobalKey<FormState>();
  final AuthController _controller = Modular.get();

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.clear();
    _passwordcontroller.clear();
  }

  void validatedForm() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> user = {
        'email': _emailcontroller.text,
        'password': _passwordcontroller.text
      };

      try {
        var response = await _controller.login(user);
        ShowSnackBarError().showSnackBar(context);
        if (response == true) {
          Modular.to.navigate('/home/prestador');
        } else {
          Modular.to.navigate('/home/empresa/');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(249, 238, 47, 1),
        leading: Image.asset(
          'assets/logo/logo.png',
          scale: 1.5,
        ),
        title: const Text(
          'HelloService',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'MavenPro',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: body(size),
    );
  }

  body(Size size) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 100, bottom: 50),
        child: Container(
          child: Column(
            children: [
              Column(
                children: [
                  /* const Text(
                    'Recrutamento rápido e flexível',
                    style: TextStyle(
                      color: Color.fromRGBO(250, 244, 127, 1),
                    ),
                  ),
                  const Text(
                    'Aumento da rede de contatos',
                    style: TextStyle(
                      color: Color.fromRGBO(250, 244, 127, 1),
                    ),
                  ), */
                  _title(),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        field(size, Validator.validateEmail, _emailcontroller,
                            'Email...', 'Email...', TextInputType.emailAddress),
                        const SizedBox(height: 30.0),
                        field(
                            size,
                            Validator.validatepassword,
                            _passwordcontroller,
                            'Senha....',
                            'Senha....',
                            null),
                      ],
                    ),
                  ),
                  _forgotPassword(size),
                  const SizedBox(height: 10),
                  _entrar(size),
                  const SizedBox(height: 10),
                  AuthButton(
                    label: 'Cadastrar-se',
                    onpressed: () => Modular.to.pushNamed('/auth/selectform/'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _forgotPassword(size) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 5, 40, 2),
              child: Text(
                'Esqueceu a Senha',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
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
      height: size.height / 14,
      width: size.width / 1.2,
      child: TextFormField(
        validator: validator,
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.white),
          label: Text(label),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white, width: 1),
          ),
        ),
      ),
    );
  }

  _entrar(size) {
    return Container(
      height: size.height / 18,
      width: size.width / 1.2,
      child: TextButton(
        onPressed: () => {
          validatedForm(),
        },
        child: Text(
          'Entrar',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        style: TextButton.styleFrom(
          backgroundColor: Color.fromRGBO(54, 59, 107, 1),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            side: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }

  _title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'Conectar-se',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
              fontSize: 36),
        ),
      ],
    );
  }
}
