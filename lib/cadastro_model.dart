import 'dart:io';

class CadastroModel {
  String nome = '';
  String cpf = '';
  String rg = '';
  String sexo = '';
  String cep = '';
  String uf = '';
  String cidade = '';
  String rua = '';
  String numero = '';
  String bairro = '';
  String complemento = '';
  String email = '';
  String senha = '';
  File? fotoUsuario;
  File? fotoCnh;

  Map<String, String> toFields() {
    return {
      'nome': nome,
      'cpf': cpf,
      'rg': rg,
      'sexo': sexo,
      'cep': cep,
      'uf': uf,
      'cidade': cidade,
      'rua': rua,
      'numero': numero,
      'bairro': bairro,
      'complemento': complemento,
      'email': email,
      'senha': senha,
    };
  }
}
