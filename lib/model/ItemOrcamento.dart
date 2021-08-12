class ItemOrcamento {
  String? _nome;
  int? _quantidade;
  double? _valor;
  double? _quantidadeNecessaria;
  double? valorUnitario;
  double? valorReal;
  //PENSAR EM UM NOME MELHOR, PQ ESSE SÓ PELA HORA DA MORTE

  ItemOrcamento(
    this._nome,
    this._quantidade,
    this._valor,
    this._quantidadeNecessaria, {
    this.valorUnitario,
    this.valorReal,
  });

  String? get nome => this._nome;
  set nome(String? value) => this._nome = value;

  int? get quantidade => this._quantidade;
  set quantidade(int? value) => this._quantidade = value;

  double? get valor => this._valor;
  set valor(double? value) => this._valor = value;

  get quantidadeNecessaria => this._quantidadeNecessaria;
  set quantidadeNecessaria(value) => this._quantidadeNecessaria = value;

  double? get getValorReal => this.valorReal;
  set setValorReal(double? valorReal) => this.valorReal = valorReal;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "nome": this._nome,
      "quantidade": this._quantidade,
      "valor": this._valor,
      "quantidadeNecessaria": this._quantidadeNecessaria,
      "valorUnitario": this.valorUnitario,
      "valorReal": this.valorReal,
    };

    return map;
  }
}
