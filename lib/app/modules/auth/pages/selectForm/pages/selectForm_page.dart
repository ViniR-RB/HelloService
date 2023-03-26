import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SelectFormPage extends StatefulWidget {
  const SelectFormPage({Key? key}) : super(key: key);

  @override
  State<SelectFormPage> createState() => _SelectFormPageState();
}

class _SelectFormPageState extends State<SelectFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 239, 66, 1),
      body: _body(),
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Image.asset('assets/logo/logo.png'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              'Selecione uma Opção',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 250, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      shape: BoxShape.rectangle),
                  child: Column(
                    children: [
                      IconButton(
                        iconSize: 80,
                        onPressed: () =>
                            Modular.to.pushNamed('/auth/selectform/prestador/'),
                        icon: Icon(Icons.people, color: Colors.black),
                      ),
                      Text(
                        'Prestador \nde Serviço',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      shape: BoxShape.rectangle),
                  child: Column(
                    children: [
                      IconButton(
                        iconSize: 80,
                        onPressed: () =>
                            Modular.to.pushNamed('/auth/selectform/empresa/'),
                        icon: Icon(
                          Icons.factory,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Empresa',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
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
}
