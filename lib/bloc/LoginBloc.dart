import 'package:calc_orcamento/Home.dart';
import 'package:calc_orcamento/Pages/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginBloc {
  FirebaseAuth auth = FirebaseAuth.instance;

  User get usuario => auth.currentUser;

  criaUsuario(String email, String senha) {
    auth
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((firebaseUser) {
      print("novo usuario: sucesso !! email: ");
    }).catchError((erro) {
      print("novo usuario: erro " + erro.toString());
    });
  }

  bool validaLogin(String email, String senha) {
    if ((email.contains("@") && email.contains(".com")) &&
        (senha.length >= 6)) {
      print("email e senha  validos");
      return true;
    } else {
      print("email e senha invalidos");
      return false;
    }
  }

  Future<bool> verficaUsuarioLogado(context) async {
    User usuarioAtual = auth.currentUser;

    if (usuarioAtual != null) {
      print("usuario logado: ${usuarioAtual.email}");
      //Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
      return true;
    } else {
      print("usuario deslogado");
      return false;
    }
  }

  logaUsuario(String email, String senha, context) {
    auth
        .signInWithEmailAndPassword(
      email: email,
      password: senha,
    )
        .then((firebaseUser) {
      print("usuario logado");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }).catchError((erro) {
      print("erro ao logar o usuario" + erro.toString());
    });
  }

  deslogaUsuario(context) async {
    await auth.signOut();
    print("deslogou o usuario");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }
}
