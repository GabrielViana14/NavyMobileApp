import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppController extends ChangeNotifier{

  static AppController instance = AppController();

  // Crie a instância do storage e uma chave para salvar
  FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const _logadoKey = 'logado';

  @visibleForTesting
  set storage(FlutterSecureStorage mockStorage) {
    _storage = mockStorage;
  }

  bool _isDarkTheme = false;
  bool _logado = false;
  String _userEmail = '';

  bool get isDarkTheme => _isDarkTheme;
  bool get logado => _logado;
  String get userEmail => _userEmail;

  // Isso será chamado pelo main.dart antes do runApp
  Future<void> loadFromStorage() async {
    // Lê o valor 'logado' do storage
    String? logadoStorage = await _storage.read(key: _logadoKey);

    // Converte a string 'true'/'false' para booleano
    _logado = logadoStorage == 'true';

  }

  // método auxiliar para salvar o estado
  Future<void> _saveLogado(bool newValue) async {
    // Salva o novo valor como string
    await _storage.write(key: _logadoKey, value: newValue.toString());
  }

  void setUserData({required String userEmail}) {
    _userEmail = userEmail;
    notifyListeners();
  }

  Future<void> logar() async {
    _logado = true;
    await _saveLogado(true);
    notifyListeners();
  }

  Future<void> deslogar() async {
    _userEmail = '';
    _logado = false;
    await _saveLogado(false);
    notifyListeners();
  }
  
  changeTheme(){
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}