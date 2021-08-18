import 'package:calc_orcamento/bloc/LoginBloc.dart';
import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key key}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  LoginBloc _loginBloc = LoginBloc();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  bool _loginEmProgresso = false;
  String _mensagemErro = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Cadastro"),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 16, top: 16, left: 16, right: 16),
                child: TextField(
                  controller: _emailController,
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "E-mail",
                    hintStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.teal,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 16, top: 0, left: 16, right: 16),
                child: TextField(
                  controller: _senhaController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Senha",
                    hintStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.teal,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                ),
              ),
              !_loginEmProgresso
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(21),
                          ),
                        ),
                      ),
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        if (_loginBloc.validaLogin(
                            _emailController.text, _senhaController.text)) {
                          setState(() {
                            _loginBloc.criaUsuario(_emailController.text,
                                _senhaController.text);
                            _loginEmProgresso = true;
                            _loginBloc.logaUsuario(_emailController.text,
                                _senhaController.text, context);
                          });
                        } else {
                          setState(() {
                            _mensagemErro = "E-mail ou senha inválidos";
                          });
                        }
                      },
                    )
                  : Container(),
              _loginEmProgresso ? CircularProgressIndicator() : Container(),
              Text(_mensagemErro),
            ],
          ),
        ),
      ),
    );
  }
}
