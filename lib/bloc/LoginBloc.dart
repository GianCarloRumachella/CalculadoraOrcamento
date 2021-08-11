import 'package:firebase_auth/firebase_auth.dart';

class LoginBloc {
  FirebaseAuth auth = FirebaseAuth.instance;

  criarUsuario(String email, String senha) {
    auth
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((firebaseUser) {
      print("novo usuario: sucesso !! email: ");
    }).catchError((erro) {
      print("novo usuario: erro " + erro.toString());
    });
  }

  verficaUsuarioLogado() async {
    User? usuarioAtual =  auth.currentUser;

    if (usuarioAtual != null) {
      print("usuario logado: ${usuarioAtual.email}");
    } else {
      print("usuario deslogado");
    }
  }

  logaUsuario(String email, String senha) {
    auth
        .signInWithEmailAndPassword(
      email: email,
      password: senha,
    )
        .then((firebaseUser) {
      print("usuario logado");
    }).catchError((erro) {
      print("erro ao logar o usuario" + erro.toString());
    });
  }

  deslogaUsuario() {
    auth.signOut();
    print("deslogou o usuario");
  }
}
