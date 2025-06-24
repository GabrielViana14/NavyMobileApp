import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'cadastro_model.dart';

class CadastroFinalPage extends StatefulWidget {
  final CadastroModel cadastro;
  const CadastroFinalPage({required this.cadastro});

  @override
  State<CadastroFinalPage> createState() => _CadastroFinalPageState();
}

class _CadastroFinalPageState extends State<CadastroFinalPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  Future<void> _selecionarImagem(bool isUserPhoto) async {
    final escolha = await showModalBottomSheet<String>(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Tirar foto'),
            onTap: () => Navigator.pop(context, 'camera'),
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Escolher da galeria'),
            onTap: () => Navigator.pop(context, 'galeria'),
          ),
        ],
      ),
    );

    if (escolha != null) {
      final XFile? image = await _picker.pickImage(
        source: escolha == 'camera' ? ImageSource.camera : ImageSource.gallery,
      );

      if (image != null) {
        setState(() {
          if (isUserPhoto) {
            widget.cadastro.fotoUsuario = File(image.path);
          } else {
            widget.cadastro.fotoCnh = File(image.path);
          }
        });
      }
    }
  }

  Future<void> _enviarCadastro() async {
    final uri = Uri.parse('https://navy-backend.onrender.com/api/users/client');
    final request = http.MultipartRequest('POST', uri);

    // Adicionar campos de texto
    request.fields.addAll(widget.cadastro.toFields());
    request.fields['email'] = _emailController.text;
    request.fields['senha'] = _senhaController.text;

    // Adicionar arquivos
    if (widget.cadastro.fotoUsuario != null) {
      request.files.add(await http.MultipartFile.fromPath('fotoUsuario', widget.cadastro.fotoUsuario!.path));
    }
    if (widget.cadastro.fotoCnh != null) {
      request.files.add(await http.MultipartFile.fromPath('fotoCnh', widget.cadastro.fotoCnh!.path));
    }

    try {
      final response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        _mostrarPopupSucesso();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao enviar cadastro: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro de conexão: $e')),
      );
    }
  }

  void _mostrarPopupSucesso() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, size: 80, color: Colors.green),
            SizedBox(height: 16),
            Text("Cadastro concluído com sucesso!", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text("Em breve entraremos em contato."),
            SizedBox(height: 8),
            Text("Um e-mail de confirmação foi enviado."),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
              child: Text("Voltar para home"),
            )
          ],
        ),
      ),
    );
  }

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
                          Container(width: 40, height: 6, color: Colors.blue),
                          _buildStepCircle(true),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                _buildTextField(_emailController, "E-mail"),
                _buildTextField(_senhaController, "Senha", obscure: true),
                _buildTextField(_confirmarSenhaController, "Confirme a Senha", obscure: true),

                SizedBox(height: 16),

                // Upload Foto Usuário
                GestureDetector(
                  onTap: () => _selecionarImagem(true),
                  child: Container(
                    height: 50,
                    color: Colors.grey[300],
                    child: Center(
                      child: Text(widget.cadastro.fotoUsuario != null ? "Foto do Usuário Selecionada" : "Selecionar Foto do Usuário"),
                    ),
                  ),
                ),

                SizedBox(height: 12),

                // Upload CNH
                GestureDetector(
                  onTap: () => _selecionarImagem(false),
                  child: Container(
                    height: 50,
                    color: Colors.grey[300],
                    child: Center(
                      child: Text(widget.cadastro.fotoCnh != null ? "Foto da CNH Selecionada" : "Selecionar Foto da CNH"),
                    ),
                  ),
                ),

                Spacer(),

                // Botão Concluir Cadastro
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (_senhaController.text != _confirmarSenhaController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('As senhas não coincidem')));
                        return;
                      }
                      if (widget.cadastro.fotoUsuario == null || widget.cadastro.fotoCnh == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Por favor, selecione as imagens.')));
                        return;
                      }

                      widget.cadastro.email = _emailController.text;
                      widget.cadastro.senha = _senhaController.text;

                      _enviarCadastro();
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
                      child: Text(
                        "Concluir Cadastro",
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

  Widget _buildTextField(TextEditingController controller, String label, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
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
