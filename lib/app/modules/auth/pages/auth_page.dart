import 'package:app/app/modules/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/utils/namedRoutes.dart';
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

  Future<void> validatedForm() async {
    if (_formKey.currentState!.validate()) {
      final user = <String, dynamic>{
        'email': _emailcontroller.text,
        'password': _passwordcontroller.text
      };

      try {
        final response = await _controller.login(
            _emailcontroller.text, _passwordcontroller.text);
        ShowSnackBarError().showSnackBar(context);
        if (response == true) {
          Modular.to.navigate(NamedRoutes.homeEmpresa);
        } else {
          Modular.to.navigate(NamedRoutes.homePrestador);
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
        backgroundColor: const Color.fromRGBO(249, 238, 47, 1),
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

  SingleChildScrollView body(Size size) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 100, bottom: 50),
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
                        field(
                          size,
                          Validator.validateEmail,
                          _emailcontroller,
                          'Email...',
                          'Email...',
                          TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 30),
                        field(
                          size,
                          Validator.validatepassword,
                          _passwordcontroller,
                          'Senha....',
                          'Senha....',
                          null,
                        ),
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

  GestureDetector _forgotPassword(size) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 5, 40, 2),
              child: const Text(
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

  SizedBox field(
    size,
    String? Function(String?)? validator,
    controller,
    label,
    hintText,
    textInputType,
  ) {
    return SizedBox(
      height: size.height / 14,
      width: size.width / 1.2,
      child: TextFormField(
        validator: validator,
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.white),
          label: Text(label),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  SizedBox _entrar(size) {
    return SizedBox(
      height: size.height / 18,
      width: size.width / 1.2,
      child: TextButton(
        onPressed: () => {
          validatedForm(),
        },
        style: TextButton.styleFrom(
          backgroundColor: const Color.fromRGBO(54, 59, 107, 1),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            side: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
        child: const Text(
          'Entrar',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Row _title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'Conectar-se',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
            fontSize: 36,
          ),
        ),
      ],
    );
  }
}
