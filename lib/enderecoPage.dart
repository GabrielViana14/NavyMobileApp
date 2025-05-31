import 'package:flutter/material.dart';

class EnderecoPage extends StatefulWidget {
  @override
  _EnderecoPageState createState() => _EnderecoPageState();
}

class _EnderecoPageState extends State<EnderecoPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Botão Voltar
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.red),
                onPressed: () {
                  Navigator.pop(context);
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
                        _buildStepCircle(true),
                        Container(width: 40, height: 6, color: Colors.blue),
                        _buildStepCircle(true),
                        Container(width: 40, height: 6, color: Colors.blue),
                        _buildStepCircle(false),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              // Formulário de Endereço
              _buildTextField("CEP", hint: "Somente números"),
              Row(
                children: [
                  Expanded(flex: 1, child: _buildTextField("UF")),
                  SizedBox(width: 16),
                  Expanded(flex: 3, child: _buildTextField("Cidade")),
                ],
              ),
              _buildTextField("Rua"),
              _buildTextField("Numero"),
              _buildTextField("Bairro"),
              _buildTextField("Complemento (opcional)", isOptional: true),

              Spacer(),

              // Botões
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Avançar para próxima etapa
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text("PRÓXIMO PASSO", style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {String? hint, bool isOptional = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label + (isOptional ? "" : " *"),
          labelStyle: TextStyle(color: Colors.blueGrey),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildStepCircle(bool isActive) {
    return Container(
      width: 20,
      height: 20,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? Colors.red : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
