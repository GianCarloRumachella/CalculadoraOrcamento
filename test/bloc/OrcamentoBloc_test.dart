import 'package:test/test.dart';
import 'package:calc_orcamento/bloc/OrcamentoBloc.dart';

void main(){
  test('Deve calcular  o valor do item', (){
    final OrcamentoBloc orcamentoBloc = OrcamentoBloc();
    const double valor = 15.0;
    const double quantidade = 20.0;
    const double valorUnitario = valor / quantidade;
   

    orcamentoBloc.calculaValorUnitario(valor, quantidade);

    expect(orcamentoBloc.calculaValorUnitario(valor, quantidade), valorUnitario);
  });

  test('Deve calcular o valor da quantidade que será usado do item no orçamento', () {
    final OrcamentoBloc orcamentoBloc = OrcamentoBloc();
    const double valor = 15.0;
    const double quantidadeNecessaria = 20.0;
    const double valorUnitario = valor / quantidadeNecessaria;
    const double valorItemQuantidade = valorUnitario * quantidadeNecessaria;

    orcamentoBloc.calculaValorReal(valorUnitario, quantidadeNecessaria);

    expect(orcamentoBloc.calculaValorReal(valorUnitario, quantidadeNecessaria), valorItemQuantidade);

    throwsA(TypeMatcher<ArgumentError>());
  });
}