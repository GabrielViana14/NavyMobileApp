import 'package:flutter_application_test/models/carro_model.dart';
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
  static Future<LoginResult?> loginUsuario(String email, String senha) async {
  final url = Uri.parse('https://navy-backend.onrender.com/api/users/login');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'email': email,
      'password': senha,
    }),
  );

  print('Response login: ${response.body}');

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final token = json['tokenJWT'];
    final userId = json['user']?['id'];

    if (token != null && userId != null) {
      await saveToken(token);
      await saveUserId(userId);
      return LoginResult(token: token, userId: userId);
    } else {
      throw Exception('Token ou UserId não encontrados na resposta');
    }
  } else {
    throw Exception('Erro ao fazer login: ${response.statusCode}');
  }
}

// Método para salvar userId localmente
static Future<void> saveUserId(String userId) async {
  await _storage.write(key: 'user_id', value: userId);
}

// Método para ler userId salvo
static Future<String?> getUserId() async {
  return await _storage.read(key: 'user_id');
}

  //receber lista com todos os carros
  static Future<List<CarroModel>> getCarros() async {
    final token = await getToken();
    final url = Uri.parse('https://navy-backend.onrender.com/api/cars/');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print('GET /cars/: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      // Filtra nulos e mapeia só itens válidos
      final carros = jsonList
        .where((item) => item != null && item is Map<String, dynamic>)
        .map<CarroModel>((json) => CarroModel.fromJson(json as Map<String, dynamic>))
        .toList();

      return carros;
    } else {
      throw Exception('Erro ao buscar carros');
    }
  }

  static Future<Map<String, dynamic>> getUsuarioPorId() async {
    final token = await getToken();
    final userId = await getUserId();

    if (token == null || userId == null) {
      throw Exception('Token ou ID do usuário não disponível');
    }

    final url = Uri.parse('https://navy-backend.onrender.com/api/users/$userId');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Erro ao buscar dados do usuário: ${response.statusCode}');
    }
  }
static Future<Map<String, dynamic>> getUsuario() async {
  final token = await getToken();
  final userId = await getUserId();
  final url = Uri.parse('https://navy-backend.onrender.com/api/users/$userId');

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Erro ao buscar usuário');
  }
}

static Future<void> atualizarUsuario(Map<String, dynamic> data) async {
  final token = await getToken();
  final userId = await getUserId();
  final url = Uri.parse('https://navy-backend.onrender.com/api/users/$userId');

  final response = await http.put(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(data),
  );

  if (response.statusCode != 200) {
    throw Exception('Erro ao atualizar usuário');
  }
}
static Future<void> deleteUserId() async {
  await _storage.delete(key: 'user_id');
}

static Future<void> updateUsuario({
  required String nome,
  required String email,
  required String cpf,
  required String rg,
  required String genero,
  required String cep,
  required String estado,
  required String municipio,
  required String rua,
  required String numero,
  required String logradouro,
}) async {
  final token = await getToken();
  final userId = await getUserId();

  if (token == null || userId == null) {
    throw Exception('Token ou UserId não encontrado');
  }

  final url = Uri.parse('https://navy-backend.onrender.com/api/users/update/$userId');

  final body = {
    "email": email,
    "user_profile": {
      "name": nome,
      "cpf": cpf,
      "rg": rg,
      "gender": genero,
      "address": {
        "cep": cep,
        "estado": estado,
        "municipio": municipio,
        "rua": rua,
        "numero": numero,
        "logradouro": logradouro,
      }
    }
  };

  print('JSON enviado no PUT: ${jsonEncode(body)}'); // print para debug

  final response = await http.put(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(body),
  );

  if (response.statusCode != 200) {
    throw Exception('Erro ao atualizar usuário: ${response.body}');
  }
}




}

class LoginResult {
  final String token;
  final String userId;

  LoginResult({required this.token, required this.userId});
}