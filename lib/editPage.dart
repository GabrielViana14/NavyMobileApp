import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String nome = '';
  String email = '';
  String senha_antiga = '';
  String senha_nova = '';
  String senha_nova_confirmacao = '';




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
              '../assets/placeholders/avatar.png',
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
                    offset: Offset(6, 7), // deslocamento da sombra
                  ),
                ],
              ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nome completo:'),
                    TextField(),
                    Text('E-mail:'),
                    TextField(),
                    Text('Senha atual:'),
                    TextField(),
                    Text('Nova senha:'),
                    TextField(),
                    Text('Confirmação nova senha:'),
                    TextField(),
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
                    offset: Offset(6, 7), // deslocamento da sombra
                  ),
                ],
              ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    offset: Offset(6, 7), // deslocamento da sombra
                  ),
                ],
              ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CEP:'),
                    TextField(),
                    Text('Estado:'),
                    TextField(),
                    Text('Municipio:'),
                    TextField(),
                    Text('Rua:'),
                    TextField(),
                    Text('Numero:'),
                    TextField(),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Logradouro:'),
                    TextField(),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}