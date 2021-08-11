import 'package:flutter/material.dart';
import 'package:calc_orcamento/bloc/LoginBloc.dart';
import 'package:calc_orcamento/bloc/OrcamentoBloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  LoginBloc calcBloc = LoginBloc();
  OrcamentoBloc orcBloc = OrcamentoBloc();

  Map<String, dynamic> itensOrc = {"item": "farinha", "preço unitario": "15,00", "quantidade": "6"};
  Map<String, dynamic> itensOrc2 = {"item": "ovo", "preço unitario": "10,00", "quantidade": "1"};
  Map<String, dynamic> itensOrc3 = {"item": "fermento", "preço unitario": "2,00", "quantidade": "0.5"};

  @override
  Widget build(BuildContext context) {
    //calcBloc.criarUsuario("giancarlo.rumachella@gmail.com", "123456");
    //calcBloc.verficaUsuarioLogado();
    //calcBloc.logaUsuario("giancarlo.rumachella@gmail.com", "123456");
    //calcBloc.deslogaUsuario();
    //orcBloc.criaOrcamento("Orcamento teste2", itensOrc);
    /* orcBloc.adicionaItemOrcamento("Orcamento teste 2", itensOrc3);
    orcBloc.adicionaItemOrcamento("Orcamento teste 2", itensOrc2);
    orcBloc.adicionaItemOrcamento("Orcamento teste 2", itensOrc); */
    orcBloc.deletaItemOrcamento("eUawsebJNh6kV26dDXVJ", "Orcamento teste 2");

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
