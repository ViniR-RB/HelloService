import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthButton extends StatelessWidget {
  final String label;
  final onpressed;
  const AuthButton({Key? key, required this.label, required this.onpressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 18,
      width: size.width / 1.2,
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
