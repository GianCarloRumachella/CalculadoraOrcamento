import 'package:calc_orcamento/model/DialogEnum.dart';
import 'package:calc_orcamento/model/ItemOrcamento.dart';
import 'package:calc_orcamento/widgets/Botao.dart';
import 'package:flutter/material.dart';
import 'package:calc_orcamento/bloc/LoginBloc.dart';
import 'package:calc_orcamento/bloc/OrcamentoBloc.dart';
import 'package:calc_orcamento/widgets/DialogTela.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class Orcamento extends StatefulWidget {
  final String nomeOrcamento;
  const Orcamento({Key key, @required this.nomeOrcamento}) : super(key: key);

  @override
  _OrcamentoState createState() => _OrcamentoState();
}

class _OrcamentoState extends State<Orcamento> {
  LoginBloc _loginBloc = LoginBloc();
  OrcamentoBloc _orcBloc = OrcamentoBloc();
  TextEditingController _lucroTextController = TextEditingController();
  TextEditingController _valorOrcamentoTextController =
      TextEditingController(text: "0.0");

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
              ItemOrcamento itemTemp = await _orcBloc.recuperaItemOrcamento(
                  item.nome, widget.nomeOrcamento);
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
          onPressed: () {
            _orcBloc.deletaItemOrcamento(nomeItem, nomeOrcamento);
            Navigator.pop(context);
            _criaRows();
          },
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
      body: SingleChildScrollView(
        child: Column(
          //padding: EdgeInsets.all(32),
          children: [
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: _dataTable(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(64, 16, 64, 8),
              child: TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _lucroTextController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                autofocus: false,
                decoration: InputDecoration(
                  labelText: "Porcentagem",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(64, 8, 64, 16),
              child: TextField(
                controller: _valorOrcamentoTextController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                autofocus: false,
                enabled: false,
                decoration: InputDecoration(
                  labelText: "Valor Total",
                ),
              ),
            ),
          ],
        ),
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
        Botao(
          label: "Calcular Orçamento",
          onPressed: () async{
            double porcentagem = double.parse(_lucroTextController.text);
            if (porcentagem <= 0) {
              porcentagem = 1;
            }
           await  _orcBloc.calculaOrcamento(porcentagem, widget.nomeOrcamento);

            _valorOrcamentoTextController.text =
                (_orcBloc.valorFinal).toStringAsFixed(2);
          },
        ),
      ],
    );
  }
}
