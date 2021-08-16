import 'package:calc_orcamento/Pages/Login.dart';
import 'package:calc_orcamento/bloc/LoginBloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LoginBloc _loginbloc = LoginBloc();
  _loginbloc.deslogaUsuario();

  runApp(MaterialApp(
    home: Login(),
  ));
}
