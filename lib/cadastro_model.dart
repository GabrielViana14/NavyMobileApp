class CadastroModel {
  // Página 1
  String nome;
  String cpf;
  String telefone;
  String dataNascimento;
  String sexo;

  // Página 2
  String cep;
  String rua;
  String numero;
  String bairro;
  String cidade;
  String estado;
  String? complemento;

  CadastroModel({
    required this.nome,
    required this.cpf,
    required this.telefone,
    required this.dataNascimento,
    required this.sexo,
    required this.cep,
    required this.rua,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.estado,
    this.complemento,
  });

  Map<String, dynamic> toJsonComEmailSenha(String email, String senha) {
    return {
      'nome': nome,
      'cpf': cpf,
      'telefone': telefone,
      'dataNascimento': dataNascimento,
      'sexo': sexo,
      'cep': cep,
      'rua': rua,
      'numero': numero,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'complemento': complemento ?? '',
      'email': email,
      'senha': senha,
    };
  }
}
