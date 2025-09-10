import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'cadastroFinalPage.dart';
import 'cadastro_model.dart';

class EnderecoPage extends StatefulWidget {
  final CadastroModel cadastro;
  const EnderecoPage({required this.cadastro, super.key});

  @override
  State<EnderecoPage> createState() => _EnderecoPageState();
}

class _EnderecoPageState extends State<EnderecoPage> {
  final _formKey = GlobalKey<FormState>();

  final _cepController = TextEditingController();
  final _ufController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _ruaController = TextEditingController();
  final _numeroController = TextEditingController();
  final _bairroController = TextEditingController();
  final _complementoController = TextEditingController();

  String? _validarObrigatorio(String? value) {
    if (value == null || value.isEmpty) return 'Campo obrigatório';
    return null;
  }

  String? _validarCep(String? value) {
    if (value == null || !RegExp(r'^\d{8}$').hasMatch(value)) return 'CEP inválido';
    return null;
  }

  Future<void> _buscarCep(String cep) async {
    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['erro'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('CEP não encontrado.')),
          );
          return;
        }

        setState(() {
          _ufController.text = data['uf'] ?? '';
          _cidadeController.text = data['localidade'] ?? '';
          _ruaController.text = data['logradouro'] ?? '';
          _bairroController.text = data['bairro'] ?? '';
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao buscar CEP.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro de conexão com o ViaCEP.')),
      );
    }
  }

  void _irParaFinal() {
    if (_formKey.currentState!.validate()) {
      final atualizado = widget.cadastro.copyWithEndereco(
        cep: _cepController.text,
        estado: _ufController.text,
        municipio: _cidadeController.text,
        rua: _ruaController.text,
        numero: _numeroController.text,
        logradouro: _bairroController.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CadastroFinalPage(cadastro: atualizado)),
      );
    }
  }

  Widget _campo(String label, TextEditingController controller,
      {TextInputType tipo = TextInputType.text, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        validator: validator ?? _validarObrigatorio,
        keyboardType: tipo,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _cepController.addListener(() {
      final cep = _cepController.text.replaceAll(RegExp(r'\D'), '');
      if (cep.length == 8) {
        _buscarCep(cep);
      }
    });
  }

  @override
  void dispose() {
    _cepController.dispose();
    _ufController.dispose();
    _cidadeController.dispose();
    _ruaController.dispose();
    _numeroController.dispose();
    _bairroController.dispose();
    _complementoController.dispose();
    super.dispose();
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
              color: Colors.white.withOpacity(0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text('Cadastro - Etapa 2', style: TextStyle(color: Colors.white, fontSize: 18)),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 24),
                      _campo('CEP *', _cepController, tipo: TextInputType.number, validator: _validarCep),
                      _campo('UF *', _ufController),
                      _campo('Cidade *', _cidadeController),
                      _campo('Rua *', _ruaController),
                      _campo('Número *', _numeroController),
                      _campo('Bairro *', _bairroController),
                      _campo('Complemento', _complementoController, validator: (_) => null),
                      SizedBox(height: 24),
                      GestureDetector(
                        onTap: _irParaFinal,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text('PRÓXIMO PASSO',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
