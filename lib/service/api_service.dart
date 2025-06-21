import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  static final _storage = FlutterSecureStorage();

  // Salva o token de forma segura
  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
  }

  // Lê o token armazenado
  static Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  // Remove o token (logout)
  static Future<void> deleteToken() async {
    await _storage.delete(key: 'jwt_token');
  }

  // Faz login, retorna token e salva localmente
  static Future<String?> loginUsuario(String email, String senha) async {
    final url = Uri.parse('https://navy-backend.onrender.com/api/users/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'}, // sempre obrigatório!
      body: jsonEncode({
          'email': email,
          'password': senha,
        }
      ),
    );
    print('Response login: ${response.body}'); // para debug

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final token = json['tokenJWT'];
      if (token != null) {
        await saveToken(token);
        return token;
      } else {
        throw Exception('Token não encontrado na resposta');
      }
    } else {
      throw Exception('Erro ao fazer login: ${response.statusCode}');
    }
  }
}
