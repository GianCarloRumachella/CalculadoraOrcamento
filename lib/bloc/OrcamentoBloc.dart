import 'dart:async';

import 'package:calc_orcamento/model/ItemOrcamento.dart';
import 'package:calc_orcamento/model/listaOrcamentos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrcamentoBloc {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  final _streamController = StreamController<List<String>>.broadcast();
  Sink<List<String>> get streamSink => _streamController.sink;
  Stream<List<String>> get orcamentoStream => _streamController.stream;

  String nomeOrcamento;
  List<String> listaOrcamentos = [];

  User get usuario => auth.currentUser;

  void dispose() {
    _streamController.close();
  }

  criaOrcamento(String nomeOrcamento) {
    ListaOrcamentos item = ListaOrcamentos(nomeOrcamento);
    print("NOME DO ORCAMENTO: " + nomeOrcamento);
    db.collection(usuario.email).doc(nomeOrcamento).set(item.toMap());
    listaOrcamentos.add(nomeOrcamento);
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

  deletaOrcamento(String nomeOrcamento) {
    db.collection(usuario.email).doc(nomeOrcamento).delete();
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

  Future<List<String>> recuperaOrcamentos() async {
    List<String> listaOrcamentos = [];
    QuerySnapshot orcamentos = await db.collection(usuario.email).get();

    for (DocumentSnapshot documentSnapshot in orcamentos.docs) {
      /* ListaOrcamentos listaOrcamentosTemp =
          ListaOrcamentos(documentSnapshot["nome"]); */
      listaOrcamentos.add(documentSnapshot.id);
      //print(listaOrcamentosTemp.toMap());
    }

    return listaOrcamentos;
  }

  Future<List<ItemOrcamento>> recuperaItensOrcamento(
      String nomeOrcamento) async {
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
