import 'package:flutter/material.dart';

class AppController extends ChangeNotifier{

  static AppController instance = AppController();

  bool isDarkTheme = false;

  bool _logado = false;
  bool get logado => _logado;


  void logar() {
    _logado = true;
    notifyListeners();
  }

  void deslogar() {
    _logado = false;
    notifyListeners();
  }
  
  changeTheme(){
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }
}