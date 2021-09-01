import 'package:calc_orcamento/model/DialogEnum.dart';
import 'package:calc_orcamento/model/ItemOrcamento.dart';
import 'package:calc_orcamento/widgets/Botao.dart';
import 'package:flutter/material.dart';
import 'package:calc_orcamento/bloc/LoginBloc.dart';
import 'package:calc_orcamento/bloc/OrcamentoBloc.dart';
import 'package:calc_orcamento/widgets/DialogTela.dart';
import 'package:flutter/rendering.dart';

class Orcamento extends StatefulWidget {
  final String nomeOrcamento;
  const Orcamento({Key key, @required this.nomeOrcamento}) : super(key: key);

  @override
  _OrcamentoState createState() => _OrcamentoState();
}

class _OrcamentoState extends State<Orcamento> {
  LoginBloc _loginBloc = LoginBloc();
  OrcamentoBloc _orcBloc = OrcamentoBloc();

  List<String> itensMenu = ["Configurações", "Sair"];
  List<DataRow> _rowList = [];

  _escolhaMenuItem(String itemEscolhido) async {
    switch (itemEscolhido) {
      case "Configurações":
        print("configurações selecionada");
        break;
      case "Sair":
        await _loginBloc.deslogaUsuario(context);
    }
  }

  _dataTable() {
    return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: Text(
            "Item",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            "Quantidade",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            "Valor",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            "Qtd Necessaria",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            "Valor Unitário",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            "Valor Real",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: _rowList,
    );
  }

  _criaRows() async {
    _rowList.clear();

    List<ItemOrcamento> tempList =
        await _orcBloc.recuperaItensOrcamento(widget.nomeOrcamento);

    for (var item in tempList) {
      _rowList.add(
        DataRow(
          cells: <DataCell>[
            DataCell(Text(item.nome), onTap: () {
              _showDialogExclusao(item.nome, widget.nomeOrcamento);
            }),
            DataCell(Text(item.quantidade.toString()), onTap: () async {
              ItemOrcamento itemTemp =
                  await _orcBloc.recuperaItemOrcamento(item.nome, widget.nomeOrcamento);
              _showDialogEdit(itemTemp);
            }),
            DataCell(Text(item.valor.toString())),
            DataCell(Text(item.quantidadeNecessaria.toString())),
            DataCell(Text(item.valorUnitario.toString())),
            DataCell(Text(item.valorReal.toString())),
          ],
        ),
      );
    }

    setState(() {});
    tempList.clear();
  }

  _showDialogExclusao(String nomeItem, String nomeOrcamento) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogTela(
          labelBotao1: "Sim",
          labelBotao2: "Não",
          nomeAlert: "Deseja excluir $nomeItem ?",
          dialogEnum: DialogEnum.exclusao,
          corpoMensagem: nomeItem,
        );
      },
    );
  }

  _showDialogEdit(ItemOrcamento item) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogTela(
          labelBotao1: "Salvar",
          labelBotao2: "Cancelar",
          nomeAlert: "Editar ${item.nome}",
          dialogEnum: DialogEnum.completa,
          itemOrcamento: item,
        );
      },
    );
  }

  @override
  void initState() {
    _criaRows();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orçamento de ${widget.nomeOrcamento}"),
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
          label: "Cadastrar Item",
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return DialogTela(
                    nomeAlert: "Inserindo itens",
                    labelBotao1: "salvar",
                    labelBotao2: "Cancelar",
                    dialogEnum: DialogEnum.completa,
                    corpoMensagem: widget.nomeOrcamento,
                  );
                });
          },
        ),
      ],
      body: Container(
        //padding: EdgeInsets.all(32),
        child: Container(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: _dataTable(),
        )),
      ),
    );
  }
}
