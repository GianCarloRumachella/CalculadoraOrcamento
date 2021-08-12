import 'package:cloud_firestore/cloud_firestore.dart';

class OrcamentoBloc {
  FirebaseFirestore db = FirebaseFirestore.instance;

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
        .collection("orcamento")
        .doc(nomeOrcamento)
        .collection("itens")
        .add(itemParaAdicionar);
  }

  deletaItemOrcamento(String idItem, String nomeOrcamento) {
    db
        .collection("orcamento")
        .doc(nomeOrcamento)
        .collection("itens")
        .doc(idItem)
        .delete();
  }

  double calculaValorUnitario(double valor, double quantidade) {
    double valorUnitario = valor / quantidade;
    return double.parse(valorUnitario.toStringAsFixed(2));
  }

//** ACHAR UM NOME MELHOR PQ ESSE TA RUIM */
  double calculaValorReal(double valorUnitario ,double quantidadeNecessaria){
     return double.parse((valorUnitario * quantidadeNecessaria).toStringAsFixed(2));
  }
}
