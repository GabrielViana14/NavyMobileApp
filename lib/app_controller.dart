import 'package:flutter/material.dart';

class AppController extends ChangeNotifier{

  static AppController instance = AppController();

  bool isDarkTheme = false;

  bool logado = false;
  //bool get logado => _logado;


  logar() {
    logado = true;
    notifyListeners();
  }

  deslogar() {
    logado = false;
    notifyListeners();
  }
  
  changeTheme(){
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }
}