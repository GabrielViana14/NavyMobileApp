import 'package:flutter/material.dart';
import 'cadastroFinalPage.dart';
import 'cadastro_model.dart';

class EnderecoPage extends StatefulWidget {
  final CadastroModel cadastro;
  const EnderecoPage({required this.cadastro, Key? key}) : super(key: key);

  @override
  State<EnderecoPage> createState() => _EnderecoPageState();
}

class _EnderecoPageState extends State<EnderecoPage> {
  final _formKey = GlobalKey<FormState>();

  final _cepController = TextEditingController();
  final _ruaController = TextEditingController();
  final _numeroController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();
  final _complementoController = TextEditingController();

  void _proximoPasso() {
    if (_formKey.currentState!.validate()) {
      final cadastroAtualizado = CadastroModel(
        nome: widget.cadastro.nome,
        cpf: widget.cadastro.cpf,
        telefone: widget.cadastro.telefone,
        dataNascimento: widget.cadastro.dataNascimento,
        sexo: widget.cadastro.sexo,
        cep: _cepController.text,
        rua: _ruaController.text,
        numero: _numeroController.text,
        bairro: _bairroController.text,
        cidade: _cidadeController.text,
        estado: _estadoController.text,
        complemento: _complementoController.text,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CadastroFinalPage(cadastro: cadastroAtualizado),
        ),
      );
    }
  }

  String? _validaObrigatorio(String? value) {
    if (value == null || value.isEmpty) return 'Campo obrigatório';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro - Endereço')),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  _buildTextField(_cepController, 'CEP'),
                  _buildTextField(_ruaController, 'Rua'),
                  _buildTextField(_numeroController, 'Número'),
                  _buildTextField(_bairroController, 'Bairro'),
                  _buildTextField(_cidadeController, 'Cidade'),
                  _buildTextField(_estadoController, 'Estado'),
                  _buildTextField(_complementoController, 'Complemento (opcional)', obrigatorio: false),
                  SizedBox(height: 24),
                  GestureDetector(
                    onTap: _proximoPasso,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          'Próximo passo',
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

  Widget _buildTextField(TextEditingController controller, String label, {bool obrigatorio = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        validator: obrigatorio ? _validaObrigatorio : null,
      ),
    );
  }
}
