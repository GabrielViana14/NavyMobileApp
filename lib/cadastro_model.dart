import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CadastroModel {
  String email;
  String senha;
  String nome;
  String telefone;
  String rg;
  String cpf;
  String sexo;
  String cnh;
  String cep;
  String rua;
  String numero;
  String estado;
  String cidade;

  CadastroModel({
    this.email = '',
    this.senha = '',
    required this.nome,
    required this.telefone,
    required this.rg,
    required this.cpf,
    required this.sexo,
    required this.cnh,
    required this.cep,
    required this.rua,
    required this.numero,
    required this.estado,
    required this.cidade,
  });

  CadastroModel copyWith({
    String? email,
    String? senha,
    String? nome,
    String? telefone,
    String? rg,
    String? cpf,
    String? sexo,
    String? cnh,
    String? cep,
    String? rua,
    String? numero,
    String? estado,
    String? cidade,
  }) {
    return CadastroModel(
      email: email ?? this.email,
      senha: senha ?? this.senha,
      nome: nome ?? this.nome,
      telefone: telefone ?? this.telefone,
      rg: rg ?? this.rg,
      cpf: cpf ?? this.cpf,
      sexo: sexo ?? this.sexo,
      cnh: cnh ?? this.cnh,
      cep: cep ?? this.cep,
      rua: rua ?? this.rua,
      numero: numero ?? this.numero,
      estado: estado ?? this.estado,
      cidade: cidade ?? this.cidade,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": senha,
      "name": nome,
      "phone": telefone,
      "rg": rg,
      "cpf": cpf,
      "gender": sexo.toLowerCase(),
      "cep": cep,
      "rua": rua,
      "numero": numero,
      "cnh": cnh,
      "logradouro": rua,
      "estado": estado.toUpperCase(),
      "municipio": cidade,
      "latitude": 0,
      "longitude": 0,
    };
  }
}