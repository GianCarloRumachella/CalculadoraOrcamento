import 'package:flutter/material.dart';
import 'package:calc_orcamento/bloc/LoginBloc.dart';
import 'package:calc_orcamento/bloc/OrcamentoBloc.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LoginBloc calcBloc = LoginBloc();
  OrcamentoBloc orcBloc = OrcamentoBloc();

  @override
  Widget build(BuildContext context) {
    /* final valorUnitario = orcBloc.calculaValorUnitario(7.00, 12);
    final valorReal = orcBloc.calculaValorReal(valorUnitario, 12); 
    ItemOrcamento itemOrcamento = ItemOrcamento("farinha", 12, 7.00, 5,
        valorUnitario: valorUnitario, valorReal: valorReal); */
    //calcBloc.criarUsuario("giancarlo.rumachella@gmail.com", "123456");
    //calcBloc.verficaUsuarioLogado();
    //calcBloc.logaUsuario("giancarlo.rumachella@gmail.com", "123456");
    //calcBloc.deslogaUsuario();
    //orcBloc.criaOrcamento("Orcamento teste2", itensOrc);
    //orcBloc.adicionaItemOrcamento("Bolo", itemOrcamento.toMap());
    /* orcBloc.adicionaItemOrcamento("Orcamento teste 2", itensOrc2);
    orcBloc.adicionaItemOrcamento("Orcamento teste 2", itensOrc); */
    //orcBloc.deletaItemOrcamento("eUawsebJNh6kV26dDXVJ", "Orcamento teste 2");
    //orcBloc.recuperaOrcamento("Bolo");
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de Orçamento"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Text("TELA DE HOME"),
        ),
      ),
    );
  }
}
