import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'cadastro_model.dart';

class CadastroFinalPage extends StatefulWidget {
  final CadastroModel cadastro;
  const CadastroFinalPage({required this.cadastro, super.key});

  @override
  State<CadastroFinalPage> createState() => _CadastroFinalPageState();
}

class _CadastroFinalPageState extends State<CadastroFinalPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();
  bool _enviando = false;

  Future<void> _enviarCadastro() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _enviando = true);

    final cadastro = widget.cadastro.copyWith(
      email: _emailController.text,
      senha: _senhaController.text,
    );

    final url = Uri.parse('https://navy-backend.onrender.com/api/users/client');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(cadastro.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _mostrarPopupSucesso();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: ${response.statusCode} - ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro de conexão: $e')),
      );
    } finally {
      setState(() => _enviando = false);
    }
  }

  void _mostrarPopupSucesso() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.verified_rounded, color: Colors.green, size: 80),
            SizedBox(height: 12),
            Text(
              "Cadastro concluído com sucesso!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Em breve entraremos em contato."),
            SizedBox(height: 4),
            Text("Um e-mail de confirmação foi enviado para o endereço informado."),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: StadiumBorder(),
              ),
              onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
              child: Text("Voltar para home", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget campo(String label, TextEditingController controller,
      {bool obscure = false, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  String? _validarEmail(String? value) {
    if (value == null || value.isEmpty) return 'Informe o e-mail';
    if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(value)) return 'E-mail inválido';
    return null;
  }

  String? _validarSenha(String? value) {
    if (value == null || value.length < 6) return 'Senha deve ter no mínimo 6 caracteres';
    return null;
  }

  String? _validarConfirmacao(String? value) {
    if (value != _senhaController.text) return 'Senhas não conferem';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3B6B6), Color(0xFF000080)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: Colors.white.withOpacity(0.1),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Cadastro - Etapa Final', style: TextStyle(color: Colors.white, fontSize: 18)),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      campo('E-mail *', _emailController,
                          validator: _validarEmail),
                      campo('Senha *', _senhaController,
                          obscure: true, validator: _validarSenha),
                      campo('Confirme Senha *', _confirmarSenhaController,
                          obscure: true, validator: _validarConfirmacao),
                      SizedBox(height: 24),
                      GestureDetector(
                        onTap: _enviando ? null : _enviarCadastro,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: _enviando ? Colors.grey : Colors.red,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              _enviando ? 'Enviando...' : 'Concluir Cadastro',
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
        ),
      ),
    );
  }
}
