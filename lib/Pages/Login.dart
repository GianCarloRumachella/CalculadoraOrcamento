import 'package:calc_orcamento/Home.dart';
import 'package:calc_orcamento/Pages/Cadastro.dart';
import 'package:calc_orcamento/bloc/LoginBloc.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  LoginBloc _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();
   
    _checaSeUsuarioEstaLogado();
  }

  _checaSeUsuarioEstaLogado() async {
    if (await _loginBloc.verficaUsuarioLogado()) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      /* Navigator.push(
          context, MaterialPageRoute(builder: (context) => Cadastro())); */
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
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
            ElevatedButton(
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
                "Login",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                _loginBloc.logaUsuario(
                    _emailController.text, _senhaController.text, context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
