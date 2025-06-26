import 'package:flutter/material.dart';
import 'enderecoPage.dart';
import 'cadastro_model.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _rgController = TextEditingController();
  final _telefoneController = TextEditingController();

  String _sexoSelecionado = 'Masculino';

  String? _validarCampoObrigatorio(String? value) {
    if (value == null || value.isEmpty) return 'Campo obrigatório';
    return null;
  }

  String? _validarCpf(String? value) {
    if (value == null || value.length != 11) return 'CPF deve ter 11 dígitos';
    return null;
  }

  void _irParaEndereco() {
    if (_formKey.currentState!.validate()) {
      final cadastro = CadastroModel(
        nome: _nomeController.text,
        cpf: _cpfController.text,
        rg: _rgController.text,
        sexo: _sexoSelecionado,
        telefone: _telefoneController.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EnderecoPage(cadastro: cadastro)),
      );
    }
  }

  Widget _campoTexto(String label, TextEditingController controller,
      {TextInputType tipo = TextInputType.text, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        keyboardType: tipo,
        validator: validator ?? _validarCampoObrigatorio,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
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
                      Text('Cadastro - Etapa 1', style: TextStyle(color: Colors.white, fontSize: 18)),
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
                      _campoTexto('Nome completo *', _nomeController),
                      _campoTexto('CPF *', _cpfController, tipo: TextInputType.number, validator: _validarCpf),
                      _campoTexto('RG *', _rgController),
                      _campoTexto('Telefone *', _telefoneController, tipo: TextInputType.phone),
                      SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _sexoSelecionado,
                        decoration: InputDecoration(
                          labelText: 'Sexo *',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        dropdownColor: Colors.black87,
                        style: TextStyle(color: Colors.white),
                        items: ['Masculino', 'Feminino']
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (value) => setState(() => _sexoSelecionado = value!),
                      ),
                      SizedBox(height: 24),
                      GestureDetector(
                        onTap: _irParaEndereco,
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
