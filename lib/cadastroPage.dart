import 'package:flutter/material.dart';
import 'cadastro_model.dart';
import 'enderecoPage.dart';

class CadastroPage extends StatefulWidget {
  final CadastroModel cadastro;
  const CadastroPage({required this.cadastro});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final rgController = TextEditingController();

  String? sexoSelecionado;

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
                          Container(width: 40, height: 6, color: Colors.grey),
                          _buildStepCircle(false),
                          Container(width: 40, height: 6, color: Colors.grey),
                          _buildStepCircle(false),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                _buildTextField(nomeController, "Nome"),
                _buildTextField(cpfController, "CPF"),
                _buildTextField(rgController, "RG"),
                _buildSexoDropdown(),

                Spacer(),

                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      widget.cadastro.nome = nomeController.text;
                      widget.cadastro.cpf = cpfController.text;
                      widget.cadastro.rg = rgController.text;
                      widget.cadastro.sexo = sexoSelecionado!;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EnderecoPage(cadastro: widget.cadastro),
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

  Widget _buildSexoDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: sexoSelecionado,
        items: ['Masculino', 'Feminino']
            .map((sexo) => DropdownMenuItem(value: sexo, child: Text(sexo)))
            .toList(),
        onChanged: (value) {
          setState(() {
            sexoSelecionado = value;
          });
        },
        decoration: InputDecoration(
          labelText: "Sexo *",
          labelStyle: TextStyle(color: Colors.blueGrey),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo, width: 2),
          ),
        ),
        validator: (value) => value == null ? 'Selecione o sexo' : null,
      ),
    );
  }
}
