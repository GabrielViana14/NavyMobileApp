import 'package:flutter/material.dart';
import 'package:flutter_application_test/enderecoPage.dart';

/*void main() {
  runApp(MaterialApp(
    home: CadastroPage(),
    debugShowCheckedModeBanner: false,
  ));
}*/

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  String? _sexoSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Botão voltar
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.red),
                onPressed: () {
                  // ação de voltar
                  Navigator.of(context).pop();
                },
              ),

              Center(
                child: Column(
                  children: [
                    Text(
                      'CADASTRO',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12),
                    // Indicador de progresso
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 6,
                          color: Colors.blue,
                        ),
                        _buildStepIndicator(false),
                        _buildStepIndicator(false),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40),

              // Campos de texto
              _buildTextField("Nome Completo"),
              _buildTextField("CPF"),
              _buildTextField("RG"),

              SizedBox(height: 24),

              Text(
                "Sexo Biológico *",
                style: TextStyle(color: Colors.blueGrey),
              ),
              Row(
                children: [
                  _buildRadio("Feminino"),
                  SizedBox(width: 20),
                  _buildRadio("Masculino"),
                ],
              ),

              Spacer(),

              // Botão "Próximo passo"
              SizedBox(
                width: double.infinity,
                child:GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EnderecoPage()),
                    );
                  },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "PRÓXIMO PASSO",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label + " *",
          labelStyle: TextStyle(color: Colors.blueGrey),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildRadio(String label) {
    return Row(
      children: [
        Radio<String>(
          value: label,
          groupValue: _sexoSelecionado,
          onChanged: (value) {
            setState(() {
              _sexoSelecionado = value;
            });
          },
          activeColor: Colors.red,
        ),
        Text(label),
      ],
    );
  }

  Widget _buildStepIndicator(bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: isActive ? Colors.red : Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
