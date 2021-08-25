import 'package:calc_orcamento/Home.dart';
import 'package:flutter/material.dart';
import 'package:calc_orcamento/widgets/Botao.dart';
import 'package:calc_orcamento/bloc/OrcamentoBloc.dart';

class DialogTela extends StatelessWidget {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _quantidadeNecessariaController =
      TextEditingController();

  final String nomeAlert;
  final String labelBotao1;
  final String labelBotao2;

  final OrcamentoBloc orcamentoBloc = OrcamentoBloc();

  DialogTela({
    this.nomeAlert,
    this.labelBotao1,
    this.labelBotao2,
  });

//** CRIAR METODO PARA VERIFICAR SE OS CAMPOS NÃO SÃO NULOS */

  save() async {
    try {
      await orcamentoBloc.adicionaItemOrcamento(
          "teste",
          orcamentoBloc
              .trataDados(_nomeController.text, _quantidadeController.text,
                  _valorController.text, _quantidadeNecessariaController.text)
              .toMap());
    } on Exception catch (e) {
      print("Exception" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(nomeAlert),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nomeController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              autofocus: false,
              decoration: InputDecoration(
                labelText: "Nome do item",
                hintText: "Nome do item",
              ),
            ),
            TextField(
              controller: _quantidadeController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              autofocus: false,
              decoration: InputDecoration(
                labelText: "Quantidade da Embalagem",
                hintText: "Quantidade de itens",
              ),
            ),
            TextField(
              controller: _valorController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              autofocus: false,
              decoration: InputDecoration(
                labelText: "Valor",
                hintText: "Valor do item",
              ),
            ),
            TextField(
              controller: _quantidadeNecessariaController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              autofocus: false,
              decoration: InputDecoration(
                labelText: "Quantidade necessária",
                hintText: "Quantidade necessária",
              ),
            ),
          ],
        ),
      ),
      actions: [
        Botao(
          label: labelBotao2,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Botao(
          label: labelBotao1,
          onPressed: () {
            save();
            _nomeController.clear();
            _quantidadeController.clear();
            _valorController.clear();
            _quantidadeController.clear();
            Navigator.pop(context);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
        ),
      ],
    );
  }
}
