import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final Color? backgroundColor;

  final Image? leading;
  const AppBarCustom({
    Key? key,
    this.actions,
    this.backgroundColor,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.black, // Define a cor desejada para o botão de voltar
      ),
      actions: actions,
      backgroundColor: backgroundColor ?? const Color.fromRGBO(249, 238, 47, 1),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leading ??
              Image.asset(
                'assets/logo/logo.png',
                scale: 1.5,
              ),
          const SizedBox(
            width: 12,
          ),
          const Text(
            'HelloService',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'MavenPro',
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
