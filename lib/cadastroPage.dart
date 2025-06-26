import 'package:flutter/material.dart';
import 'cadastro_model.dart';
import 'enderecoPage.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _rgController = TextEditingController();
  final _cpfController = TextEditingController();

  String _sexoSelecionado = 'masculino';

  void _irParaEndereco() {
    if (_formKey.currentState!.validate()) {
      final cadastro = CadastroModel(
        nome: _nomeController.text,
        telefone: _telefoneController.text,
        rg: _rgController.text,
        cpf: _cpfController.text,
        sexo: _sexoSelecionado,
        cnh: '',
        cep: '',
        rua: '',
        numero: '',
        estado: '',
        cidade: '',
      );
      Navigator.push(context, MaterialPageRoute(builder: (_) => EnderecoPage(cadastro: cadastro)));
    }
  }

  String? validarCPF(String? value) {
    if (value == null || value.isEmpty) return 'CPF obrigatório';
    if (!RegExp(r'^\d{11}$').hasMatch(value)) return 'CPF inválido';
    return null;
  }

  String? validarTelefone(String? value) {
    if (value == null || value.isEmpty) return 'Telefone obrigatório';
    if (!RegExp(r'^\d{10,11}$').hasMatch(value)) return 'Telefone inválido';
    return null;
  }

  Widget campo(String label, TextEditingController controller, {TextInputType? tipo, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: tipo,
        decoration: InputDecoration(
          labelText: '$label *',
          labelStyle: TextStyle(color: Colors.indigo),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo, width: 2),
          ),
        ),
      ),
    );
  }

  Widget etapas() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (i) => Padding(
          padding: EdgeInsets.all(4),
          child: CircleAvatar(radius: 8, backgroundColor: i == 0 ? Colors.red : Colors.grey[300]),
        )),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.red),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        Expanded(
                          child: Center(child: Text('CADASTRO - ETAPA 1', style: TextStyle(fontSize: 16, color: Colors.indigo))),
                        ),
                        SizedBox(width: 48),
                      ],
                    ),
                    etapas(),
                    campo('Nome completo', _nomeController),
                    campo('Telefone', _telefoneController, tipo: TextInputType.phone, validator: validarTelefone),
                    campo('RG', _rgController),
                    campo('CPF', _cpfController, tipo: TextInputType.number, validator: validarCPF),
                    DropdownButtonFormField(
                      value: _sexoSelecionado,
                      items: ['masculino', 'feminino'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (v) => setState(() => _sexoSelecionado = v!),
                      decoration: InputDecoration(labelText: 'Sexo *', labelStyle: TextStyle(color: Colors.indigo)),
                    ),
                    SizedBox(height: 24),
                    GestureDetector(
                      onTap: _irParaEndereco,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(30)),
                        child: Center(child: Text('Próximo passo', style: TextStyle(color: Colors.white))),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
