import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  final String label;
  final Function onPressed;

  Botao({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
