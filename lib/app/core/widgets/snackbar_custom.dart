import 'package:flutter/material.dart';

class CustomSnackBar {
  final String content;
  final String label;
  void Function() onTap;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
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

    _scaffoldKey.currentState?.showSnackBar(snackBar);
  }
}
