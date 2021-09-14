import 'package:calc_orcamento/Pages/Orcamento.dart';
import 'package:calc_orcamento/bloc/LoginBloc.dart';
import 'package:calc_orcamento/bloc/OrcamentoBloc.dart';
import 'package:calc_orcamento/model/DialogEnum.dart';
import 'package:calc_orcamento/widgets/Botao.dart';
import 'package:calc_orcamento/widgets/DialogTela.dart';
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
  List<String> listaOrcamentos = [];

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

  Future<void> _pegaOrcamentos() async {
    listaOrcamentos = await _orcamentoBloc.recuperaOrcamentos();
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
        child: RefreshIndicator(
          onRefresh: () => _pegaOrcamentos(),
          child: ListView.builder(
            itemCount: listaOrcamentos.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(listaOrcamentos[index]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Orcamento(
                        nomeOrcamento: listaOrcamentos[index],
                      ),
                    ),
                  );
                },
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DialogTela(
                        dialogEnum: DialogEnum.exclusao,
                        labelBotao1: "Sim",
                        labelBotao2: "Não",
                        nomeAlert: "Deseja excluir ${listaOrcamentos[index]}?",
                        corpoMensagem: listaOrcamentos[index],
                        onPressed: (){
                          _orcamentoBloc.deletaOrcamento(listaOrcamentos[index]);
                          _pegaOrcamentos();
                          Navigator.pop(context);
                        },
                        
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
