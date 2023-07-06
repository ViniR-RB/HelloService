import 'package:flutter/material.dart';

class CustomSnackBar {
  final String content;
  final String label;
  void Function() onTap;
  static final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  CustomSnackBar({
    required this.content,
    required this.label,
    required this.onTap,
  });

  void showSnackBar() {
    final snackBar = SnackBar(
      content: Text(content),
      action: SnackBarAction(
        label: label,
        onPressed: onTap,
      ),
    );
    scaffoldKey.currentState?.showSnackBar(snackBar);
    Future.delayed(const Duration(seconds: 2))
        .then((value) => scaffoldKey.currentState?.removeCurrentSnackBar());
  }
}
