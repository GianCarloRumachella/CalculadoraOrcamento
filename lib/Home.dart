import 'package:flutter/material.dart';
import 'package:calc_orcamento/bloc/CalcBloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CalcBloc calcBloc = CalcBloc();

  @override
  Widget build(BuildContext context) {
    //calcBloc.criarUsuario("giancarlo.rumachella@gmail.com", "123456");
    //calcBloc.verficaUsuarioLogado();
    //calcBloc.logaUsuario("giancarlo.rumachella@gmail.com", "123456");
    //calcBloc.deslogaUsuario();

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
