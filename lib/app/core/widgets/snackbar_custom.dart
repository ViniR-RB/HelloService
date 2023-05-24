import 'package:flutter/material.dart';

class ShowSnackBarError {
  final String content;
  final String label;
  void Function() onTap;
  ShowSnackBarError({
    required this.content,
    required this.label,
    required this.onTap,
  });

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(content),
      action: SnackBarAction(
        label: label,
        onPressed: onTap,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
