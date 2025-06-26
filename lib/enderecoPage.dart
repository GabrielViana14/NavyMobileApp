import 'package:flutter/material.dart';
import 'cadastro_model.dart';
import 'cadastroFinalPage.dart';

class EnderecoPage extends StatefulWidget {
  final CadastroModel cadastro;
  const EnderecoPage({required this.cadastro, super.key});

  @override
  State<EnderecoPage> createState() => _EnderecoPageState();
}

class _EnderecoPageState extends State<EnderecoPage> {
  final _formKey = GlobalKey<FormState>();
  final _cepController = TextEditingController();
  final _ruaController = TextEditingController();
  final _numeroController = TextEditingController();
  final _estadoController = TextEditingController();
  final _cidadeController = TextEditingController();

  String? validarCEP(String? value) {
    if (value == null || value.isEmpty) return 'CEP obrigatório';
    if (!RegExp(r'^\d{5}-?\d{3}$').hasMatch(value)) return 'CEP inválido';
    return null;
  }

  void _finalizar() {
    if (_formKey.currentState!.validate()) {
      final cadastro = widget.cadastro.copyWith(
        cep: _cepController.text,
        rua: _ruaController.text,
        numero: _numeroController.text,
        estado: _estadoController.text,
        cidade: _cidadeController.text,
      );
      Navigator.push(context, MaterialPageRoute(builder: (_) => CadastroFinalPage(cadastro: cadastro)));
    }
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
          child: CircleAvatar(radius: 8, backgroundColor: i <= 1 ? Colors.red : Colors.grey[300]),
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
                    Center(child: Text('CADASTRO - ETAPA 2', style: TextStyle(fontSize: 16, color: Colors.indigo))),
                    etapas(),
                    campo('CEP', _cepController, tipo: TextInputType.number, validator: validarCEP),
                    campo('Rua', _ruaController),
                    campo('Número', _numeroController),
                    campo('Estado', _estadoController),
                    campo('Município', _cidadeController),
                    SizedBox(height: 24),
                    GestureDetector(
                      onTap: _finalizar,
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
