import 'package:flutter/material.dart';
import 'package:flutter_application_test/cadastroFinalPage.dart';
import 'cadastro_model.dart';
//import 'cadastroFinalPage.dart';

class EnderecoPage extends StatefulWidget {
  final CadastroModel cadastro;
  const EnderecoPage({required this.cadastro});

  @override
  State<EnderecoPage> createState() => _EnderecoPageState();
}

class _EnderecoPageState extends State<EnderecoPage> {
  final _formKey = GlobalKey<FormState>();
  final cepController = TextEditingController();
  final ufController = TextEditingController();
  final cidadeController = TextEditingController();
  final ruaController = TextEditingController();
  final numeroController = TextEditingController();
  final bairroController = TextEditingController();
  final complementoController = TextEditingController();

  String? _validaCampo(String? value) => value == null || value.isEmpty ? 'Campo obrigatório' : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.red),
                  onPressed: () => Navigator.pop(context),
                ),

                Center(
                  child: Column(
                    children: [
                      Text('CADASTRO', style: TextStyle(fontSize: 16, color: Colors.blueGrey, fontWeight: FontWeight.w500)),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildStepCircle(true),
                          Container(width: 40, height: 6, color: Colors.blue),
                          _buildStepCircle(true),
                          Container(width: 40, height: 6, color: Colors.grey),
                          _buildStepCircle(false),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                _buildTextField(cepController, "CEP"),
                _buildTextField(ufController, "UF"),
                _buildTextField(cidadeController, "Cidade"),
                _buildTextField(ruaController, "Rua"),
                _buildTextField(numeroController, "Número"),
                _buildTextField(bairroController, "Bairro"),
                _buildTextField(complementoController, "Complemento"),

                Spacer(),

                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      widget.cadastro.cep = cepController.text;
                      widget.cadastro.uf = ufController.text;
                      widget.cadastro.cidade = cidadeController.text;
                      widget.cadastro.rua = ruaController.text;
                      widget.cadastro.numero = numeroController.text;
                      widget.cadastro.bairro = bairroController.text;
                      widget.cadastro.complemento = complementoController.text;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CadastroFinalPage(cadastro: widget.cadastro),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text("Próximo Passo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepCircle(bool ativo) {
    return Container(
      width: 20,
      height: 20,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: ativo ? Colors.red : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        validator: _validaCampo,
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
