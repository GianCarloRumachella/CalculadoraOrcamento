class ListaOrcamentos {
  String _nomeOrcamentos;

  ListaOrcamentos(this._nomeOrcamentos);

  String get getNomeOrcamentos => this._nomeOrcamentos;
  set setNomeOrcamentos(String nomeOrcamentos) => this._nomeOrcamentos = nomeOrcamentos;

   Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "nome": this._nomeOrcamentos,
    };

    return map;
  }
}
