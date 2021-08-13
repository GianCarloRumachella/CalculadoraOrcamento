import 'package:calc_orcamento/model/ItemOrcamento.dart';
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

  Future recuperaOrcamento(String nomeOrcamento) async {
    QuerySnapshot querySnapshot = await db
        .collection("orcamento")
        .doc(nomeOrcamento)
        .collection("itens")
        .get();
    for (DocumentSnapshot documento in querySnapshot.docs) {
      ItemOrcamento itemOrcamento = ItemOrcamento(
        documento["nome"],
        documento["quantidade"],
        documento["valor"],
        documento["quantidadeNecessaria"],
      );
      //itemOrcamento.nome = "xalala";
      print(itemOrcamento.toMap());

      //adicionaItemOrcamento(nomeOrcamento, itemOrcamento.toMap());
    }
    
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
}
