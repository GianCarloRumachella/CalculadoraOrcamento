import 'package:calc_orcamento/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginBloc {
  FirebaseAuth auth = FirebaseAuth.instance;

//** VERIFICAR SE USUARIO E SENHA SÃO VALIDOS */


  criarUsuario(String email, String senha) {
    auth
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((firebaseUser) {
      print("novo usuario: sucesso !! email: ");
    }).catchError((erro) {
      print("novo usuario: erro " + erro.toString());
    });
  }

  Future<bool> verficaUsuarioLogado() async {
    User usuarioAtual =  auth.currentUser;

    if (usuarioAtual != null) {
      print("usuario logado: ${usuarioAtual.email}");
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
     Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));

    }).catchError((erro) {
      print("erro ao logar o usuario" + erro.toString());
      
    });
  }

  deslogaUsuario() {
    auth.signOut();
    print("deslogou o usuario");
  }
}
