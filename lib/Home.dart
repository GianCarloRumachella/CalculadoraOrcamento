import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de Orçamento"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Text(
            "INICIANDO O PROJETO",
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}
