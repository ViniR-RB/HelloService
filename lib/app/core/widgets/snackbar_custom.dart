import 'package:flutter/material.dart';

class ShowSnackBarError {
  final String? content;
  final String? label;
  void Function()? onTap;
  ShowSnackBarError({
    this.content,
    this.label,
    this.onTap,
  });

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(content ?? 'Ocorreu Algum Erro'),
      action: SnackBarAction(
        label: label ?? 'Tente Novamente',
        onPressed: onTap ?? () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
