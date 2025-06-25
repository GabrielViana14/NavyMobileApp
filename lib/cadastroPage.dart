import 'package:flutter/material.dart';
import 'enderecoPage.dart';
import 'cadastro_model.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _dataNascimentoController = TextEditingController();

  String? _sexoSelecionado;

  void _proximoPasso() {
    if (_formKey.currentState!.validate()) {
      final cadastro = CadastroModel(
        nome: _nomeController.text,
        cpf: _cpfController.text,
        telefone: _telefoneController.text,
        dataNascimento: _dataNascimentoController.text,
        sexo: _sexoSelecionado ?? '',
        cep: '',
        rua: '',
        numero: '',
        bairro: '',
        cidade: '',
        estado: '',
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EnderecoPage(cadastro: cadastro),
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
      appBar: AppBar(title: Text('Cadastro - Etapa 1')),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  _buildTextField(_nomeController, 'Nome completo'),
                  _buildTextField(_cpfController, 'CPF'),
                  _buildTextField(_telefoneController, 'Telefone'),
                  _buildTextField(_dataNascimentoController, 'Data de nascimento (DD/MM/AAAA)'),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Sexo'),
                    value: _sexoSelecionado,
                    items: ['Masculino', 'Feminino']
                        .map((sexo) => DropdownMenuItem(value: sexo, child: Text(sexo)))
                        .toList(),
                    onChanged: (value) => setState(() => _sexoSelecionado = value),
                    validator: (value) => value == null ? 'Campo obrigatório' : null,
                  ),
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

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        validator: _validaObrigatorio,
      ),
    );
  }
}
