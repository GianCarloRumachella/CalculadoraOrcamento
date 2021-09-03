import 'package:calc_orcamento/Pages/Orcamento.dart';
import 'package:calc_orcamento/bloc/LoginBloc.dart';
import 'package:calc_orcamento/bloc/OrcamentoBloc.dart';
import 'package:calc_orcamento/model/DialogEnum.dart';
import 'package:calc_orcamento/model/listaOrcamentos.dart';
import 'package:calc_orcamento/widgets/Botao.dart';
import 'package:calc_orcamento/widgets/DialogTela.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LoginBloc _loginBloc = LoginBloc();
  OrcamentoBloc _orcamentoBloc = OrcamentoBloc();

  List<String> itensMenu = ["Configurações", "Sair"];
  List<ListaOrcamentos> listaOrcamentos = [];

  _escolhaMenuItem(String itemEscolhido) async {
    switch (itemEscolhido) {
      case "Configurações":
        print("configurações selecionada");
        break;
      case "Sair":
        await _loginBloc.deslogaUsuario(context);
    }
  }

  @override
  void initState() {
    _pegaOrcamentos();
    super.initState();
  }

  _pegaOrcamentos() async {
    listaOrcamentos = await _orcamentoBloc.recuperaOrcamentos();

    //print("TEMPLIST: ${listaOrcamentos.length.toString()}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orçamentos"),
        actions: [
          PopupMenuButton(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          ),
        ],
      ),
      persistentFooterButtons: [
        Botao(
          label: "Criar novo Orçamento",
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return DialogTela(
                    nomeAlert: "Novo Orçamento",
                    labelBotao1: "Criar",
                    labelBotao2: "Cancelar",
                    dialogEnum: DialogEnum.simples,
                  );
                });
          },
        ),
        Botao(
          label: "teste",
          onPressed: () {
            _pegaOrcamentos();
          },
        ),
      ],
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: ListView.builder(
            itemCount: listaOrcamentos.length,
            itemBuilder: (context, index) {
              return TextButton(
                onPressed: () {
                  _orcamentoBloc
                      .criaOrcamento(listaOrcamentos[index].getNomeOrcamentos);
                  String nomeOrcamento =
                      listaOrcamentos[index].getNomeOrcamentos;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Orcamento(
                        nomeOrcamento: nomeOrcamento,
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(listaOrcamentos[index].getNomeOrcamentos),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
