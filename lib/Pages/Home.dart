import 'package:calc_orcamento/Pages/Orcamento.dart';
import 'package:calc_orcamento/bloc/LoginBloc.dart';
import 'package:calc_orcamento/bloc/OrcamentoBloc.dart';
import 'package:calc_orcamento/model/DialogEnum.dart';
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
    super.initState();
    _pegaOrcamentos();
  }

  List<String>_pegaOrcamentos(){
    return _orcamentoBloc.listaOrcamentos;
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
      ],
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
         /*  child: StreamBuilder(
            stream: _orcamentoBloc.recuperaOrcamentosNovo(),
            builder: (context, snapshot) {
              QuerySnapshot querySnapshot = snapshot.data;
              if (!snapshot.hasError) {
                return ListView.builder(
                  itemCount: querySnapshot.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _orcamentoBloc.listaOrcamentos[index],
                      ),
                    );
                  },
                );
              } else {
                Text("ERRO!!!");
              }
            },
          ), */
           child: ListView.builder(
            itemCount: _pegaOrcamentos().length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  _pegaOrcamentos()[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
