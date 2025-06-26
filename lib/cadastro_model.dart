class CadastroModel {
  final String nome;
  final String cpf;
  final String rg;
  final String? telefone;

  final String sexo;
  final String? email;
  final String? senha;

  final String? cep;
  final String? estado;
  final String? municipio;
  final String? rua;
  final String? numero;
  final String? logradouro;

  CadastroModel({
    required this.nome,
    required this.cpf,
    required this.rg,
    required this.sexo,
    this.telefone,

    this.email,
    this.senha,
    this.cep,
    this.estado,
    this.municipio,
    this.rua,
    this.numero,
    this.logradouro,
  });

  CadastroModel copyWith({
    String? nome,
    String? cpf,
    String? rg,
    String? telefone,
    String? sexo,
    String? email,
    String? senha,
    String? cep,
    String? estado,
    String? municipio,
    String? rua,
    String? numero,
    String? logradouro,
  }) {
    return CadastroModel(
      nome: nome ?? this.nome,
      cpf: cpf ?? this.cpf,
      rg: rg ?? this.rg,
      telefone: telefone ?? this.telefone,
      sexo: sexo ?? this.sexo,
      email: email ?? this.email,
      senha: senha ?? this.senha,
      cep: cep ?? this.cep,
      estado: estado ?? this.estado,
      municipio: municipio ?? this.municipio,
      rua: rua ?? this.rua,
      numero: numero ?? this.numero,
      logradouro: logradouro ?? this.logradouro,
    );
  }

  CadastroModel copyWithEndereco({
    String? cep,
    String? estado,
    String? municipio,
    String? rua,
    String? numero,
    String? logradouro,
  }) {
    return copyWith(
      cep: cep,
      estado: estado,
      municipio: municipio,
      rua: rua,
      numero: numero,
      logradouro: logradouro,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': senha,
      'name': nome,
     'phone': telefone ?? '',
      'rg': rg,
      'cpf': cpf,
      'gender': sexo.toLowerCase(),
      'cep': cep,
      'rua': rua,
      'numero': numero,
      'cnh': '', // opcional
      'logradouro': logradouro,
      'estado': estado,
      'municipio': municipio,
      'latitude': 0,
      'longitude': 0,
    };
  }
}
