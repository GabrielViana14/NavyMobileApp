import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum Genero { masculino, feminino }
class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController nome = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController senhaAntiga = TextEditingController();
  final TextEditingController senhaNova = TextEditingController();
  final TextEditingController senhaNovaConfirmacao = TextEditingController();
  final TextEditingController CPF = TextEditingController();
  final TextEditingController RG = TextEditingController();
  final TextEditingController CEP = TextEditingController();
  final TextEditingController estado = TextEditingController();
  final TextEditingController municipio = TextEditingController();
  final TextEditingController rua = TextEditingController();
  final TextEditingController numero = TextEditingController();
  final TextEditingController logradouro = TextEditingController();
  Genero? _generoSelecionado;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Conta"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/placeholders/avatar.png',
                width: 150,
                height: 150,
            ),
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 130.0,
                    height: 35.0,
                    margin: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFF3535B5),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(
                      'Alterar foto',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(32.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 8,
                    offset: Offset(2, 4), // deslocamento da sombra
                  ),
                ],
              ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nome completo:'),
                    CustomTextField(controller: nome),
                    Text('E-mail:'),
                    CustomTextField(controller: email),
                    Text('Senha atual:'),
                    CustomTextField(controller: senhaAntiga),
                    Text('Nova senha:'),
                    CustomTextField(controller: senhaNova),
                    Text('Confirmação nova senha:'),
                    CustomTextField(controller: senhaNovaConfirmacao),
                    
                  ],
                ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(32.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 8,
                    offset: Offset(2, 4), // deslocamento da sombra
                  ),
                ],
              ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sexo Biológico:'),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: const Text("Masculino"),
                            value: Genero.masculino,
                            groupValue: _generoSelecionado,
                            onChanged: (Genero? value){
                              setState(() {
                                _generoSelecionado = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: const Text("Feminino"),
                            value: Genero.feminino,
                            groupValue: _generoSelecionado,
                            onChanged: (Genero? value){
                              setState(() {
                                _generoSelecionado = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Text('RG:'),
                    RGTextField(controller: RG),
                    Text('CPF:'),
                    CPFTextField(controller: CPF)
                  ],
                ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(32.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 8,
                    offset: Offset(2, 4), // deslocamento da sombra
                  ),
                ],
              ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CEP:'),
                    CustomTextField(controller: CEP),
                    Text('Estado:'),
                    CustomTextField(controller: estado),
                    Text('Municipio:'),
                    CustomTextField(controller: municipio),
                    Text('Rua:'),
                    CustomTextField(controller: rua),
                    Text('Numero:'),
                    CustomTextField(controller: numero),
                    Text('Logradouro:'),
                    CustomTextField(controller: logradouro),
                  ],
                ),
            ),
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200.0,
                    height: 40.0,
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFF3535B5),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(
                      'Salvar Alterações',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
              onTap: (){
                print('Alterações salvas');
                Navigator.of(context).pop();
                
              },
            ),
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 170.0,
                    height: 35.0,
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFFB5B4D),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
              onTap: (){
                print('Alterações canceladas');
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  const CustomTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(
          color: Colors.black.withValues(alpha: (0.0025 * 255.0).toDouble()),
          blurRadius: 8,
          offset: Offset(2, 4),
        )],  
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none
        ),
      ),
    );
  }
}

class CPFTextField extends StatelessWidget {
  CPFTextField({super.key, required this.controller});

  final TextEditingController controller;
  final cpfMaskFormatter = MaskTextInputFormatter( // Formato do CPF
  mask: '###.###.###-##',
  filter: { "#": RegExp(r'[0-9]') },
);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(
          color: Colors.black.withValues(alpha: (0.0025 * 255.0).toDouble()),
          blurRadius: 8,
          offset: Offset(2, 4),
        )],  
      ),
      child: TextField(
        controller: controller,
        inputFormatters: [cpfMaskFormatter],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '000.000.000-00',
        ),
      ),
    );
  }
}

class RGTextField extends StatelessWidget {
  RGTextField({super.key, required this.controller});

  final TextEditingController controller;
  final rgMaskFormatter = MaskTextInputFormatter( // Formato do RG
  mask: '##.###.###-#',
  filter: { "#": RegExp(r'[0-9]') },
);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(
          color: Colors.black.withValues(alpha: (0.0025 * 255.0).toDouble()),
          blurRadius: 8,
          offset: Offset(2, 4),
        )],  
      ),
      child: TextField(
        controller: controller,
        inputFormatters: [rgMaskFormatter],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '000.000.000-00',
        ),
      ),
    );
  }
}