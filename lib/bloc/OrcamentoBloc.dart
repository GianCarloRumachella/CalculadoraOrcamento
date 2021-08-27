import 'package:calc_orcamento/model/ItemOrcamento.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrcamentoBloc {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  User get usuario => auth.currentUser;

  criaOrcamento(String nomeOrcamento, Map<String, dynamic> itensOrcamento) {
    db
        .collection("orcamento")
        .doc(nomeOrcamento)
        .collection("itens")
        .add(itensOrcamento);
  }

  adicionaItemOrcamento(
    String nomeOrcamento,
    Map<String, dynamic> itemParaAdicionar,
  ) {
    db
        .collection(usuario.email)
        .doc(nomeOrcamento)
        .collection("itens")
        .doc(itemParaAdicionar["nome"])
        .set(itemParaAdicionar);
  }

  deletaItemOrcamento(String idItem, String nomeOrcamento) {
    db
        .collection(usuario.email)
        .doc(nomeOrcamento)
        .collection("itens")
        .doc(idItem)
        .delete();
  }

  Future<ItemOrcamento> recuperaItemOrcamento(
      String idItem, String nomeOrcamento) async {
    var item = await db
        .collection(usuario.email)
        .doc(nomeOrcamento)
        .collection("itens")
        .doc(idItem)
        .get();

    ItemOrcamento itemOrcamento = ItemOrcamento(
      item["nome"],
      item["quantidade"],
      item["valor"],
      item["quantidadeNecessaria"],
      valorUnitario: calculaValorUnitario(item["valor"], item["quantidade"]),
      valorReal: calculaValorReal(
        calculaValorUnitario(item["valor"], item["quantidade"]),
        item["quantidadeNecessaria"],
      ),
    );

    return itemOrcamento;
  }

  Future<List<ItemOrcamento>> recuperaOrcamento(String nomeOrcamento) async {
    List<ItemOrcamento> itensOrcamento = [];

    QuerySnapshot querySnapshot = await db
        .collection(usuario.email)
        .doc(nomeOrcamento)
        .collection("itens")
        .get();
    for (DocumentSnapshot documento in querySnapshot.docs) {
      ItemOrcamento itemOrcamento = ItemOrcamento(
        documento["nome"],
        documento["quantidade"],
        documento["valor"],
        documento["quantidadeNecessaria"],
        valorUnitario: documento["valorUnitario"],
        valorReal: documento["valorReal"],
      );

      itensOrcamento.add(itemOrcamento);
      print(itemOrcamento.toMap());
    }

    return itensOrcamento;
  }

  double calculaValorUnitario(double valor, double quantidade) {
    double valorUnitario = valor / quantidade;
    return double.parse(valorUnitario.toStringAsFixed(2));
  }

//** ACHAR UM NOME MELHOR PQ ESSE TA RUIM */
  double calculaValorReal(double valorUnitario, double quantidadeNecessaria) {
    return double.parse(
        (valorUnitario * quantidadeNecessaria).toStringAsFixed(2));
  }

  //**REFATORAR POSTERIORMENTE ACHAR BONS NOMES PARA AS VARIAVEIS, PQ SÓ POR DEUS MESMO */
  ItemOrcamento trataDados(String nome, String quantidade, String valor,
      String quantidadeNecessaria) {
    double quantidadeDouble;
    double valorDouble,
        quantidadeNecessariaDouble,
        valorUnitarioDouble,
        valorRealDouble;

    nome.isEmpty ? nome = "" : nome;
    quantidade.isEmpty
        ? quantidadeDouble = 0
        : quantidadeDouble = double.parse(quantidade);

    valor.isEmpty ? valorDouble = 0 : valorDouble = double.parse(valor);

    quantidadeNecessaria.isEmpty
        ? quantidadeNecessariaDouble = 0
        : quantidadeNecessariaDouble = double.parse(quantidadeNecessaria);

    valorUnitarioDouble = calculaValorUnitario(valorDouble, quantidadeDouble);

    valorRealDouble =
        calculaValorReal(valorUnitarioDouble, quantidadeNecessariaDouble);

    return ItemOrcamento(
        nome, quantidadeDouble, valorDouble, quantidadeNecessariaDouble,
        valorUnitario: valorUnitarioDouble, valorReal: valorRealDouble);
  }
}
