import 'package:app/app/modules/auth/pages/signin/signi_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../widgets/auth_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isnew = true;

  final SignInController _controller = Modular.get();

  String? validatepassword(String? value) {
    if (value!.length <= 6 || value == null) {
      return 'A sua senha deve conter mais de 6 caracteres';
    } else {
      return null;
    }
  }

  String? _validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Preencha com um e-mail válido';
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.clear();
    _passwordcontroller.clear();
  }

  void validatedForm() async {
    if (_formKey.currentState!.validate()) {
      final snackBar = SnackBar(
        content: const Text('Email em uso'),
        action: SnackBarAction(
          label: 'Continuar',
          onPressed: () {},
        ),
      );
      var exists = await _controller.signIn(_nameController.text,
          _emailcontroller.text, _passwordcontroller.text);

      if (exists == true) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        _controller.signIn(
            _nameController, _emailcontroller.text, _passwordcontroller.text);
        isnew
            ? Modular.to.navigate('/auth/selectform/')
            : Modular.to.navigate('/home/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: body(size),
    );
  }

  _Appbar() {
    return AppBar(
      backgroundColor: Color.fromRGBO(249, 238, 47, 1),
    );
  }

  body(size) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
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
          ),
          _title(),
          const SizedBox(height: 30),
          Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30),
                field(size, null, _nameController, 'Name...', 'Name...',
                    TextInputType.emailAddress),
                const SizedBox(height: 30),
                field(size, _validateEmail, _emailcontroller, 'Email...',
                    'Email...', TextInputType.emailAddress),
                const SizedBox(height: 30.0),
                field(size, validatepassword, _passwordcontroller, 'Senha....',
                    'Senha....', null),
              ],
            ),
          ),
          _forgotPassword(size),
          const SizedBox(height: 10),
          // _entrar(size),
          const SizedBox(height: 10),
          AuthButton(
            label: 'Cadastrar',
            onpressed: () => validatedForm(),
          ),
        ],
      ),
    );
  }

  _forgotPassword(size) {
    return GestureDetector(
      onTap: () {
        Modular.to.navigate('/auth');
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 5, 40, 2),
              child: const Text(
                'Fazer Login',
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
        onPressed: () {
          validatedForm();
          Modular.to.navigate('auth/form/');
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
          'Cadastrar-se',
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
