import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cadastro_model.dart';

class CadastroFinalPage extends StatefulWidget {
  final CadastroModel cadastro;
  const CadastroFinalPage({required this.cadastro, Key? key}) : super(key: key);

  @override
  State<CadastroFinalPage> createState() => _CadastroFinalPageState();
}

class _CadastroFinalPageState extends State<CadastroFinalPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  String? _validaEmail(String? value) {
    if (value == null || value.isEmpty) return 'Campo obrigatório';
    if (!value.contains('@')) return 'E-mail inválido';
    return null;
  }

  String? _validaSenha(String? value) {
    if (value == null || value.isEmpty) return 'Campo obrigatório';
    if (value.length < 6) return 'Mínimo 6 caracteres';
    return null;
  }

  Future<void> _enviarCadastro() async {
    final uri = Uri.parse('https://navy-backend.onrender.com/api/users/client');

    final body = widget.cadastro.toJsonComEmailSenha(
      _emailController.text,
      _senhaController.text,
    );

    try {
      final response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _mostrarPopupSucesso();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: ${response.statusCode}\n${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro de conexão: $e')),
      );
    }
  }

  void _mostrarPopupSucesso() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Cadastro concluído"),
        content: Text("Dados enviados com sucesso!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro - Final')),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  _buildTextField(_emailController, "Email", validator: _validaEmail),
                  _buildTextField(_senhaController, "Senha", obscure: true, validator: _validaSenha),
                  SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _enviarCadastro();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Concluir Cadastro",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        decoration: InputDecoration(
          labelText: "$label *",
          labelStyle: TextStyle(color: Colors.blueGrey),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo, width: 2),
          ),
        ),
      ),
    );
  }
}
