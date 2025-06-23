import 'package:flutter_application_test/models/location_model.dart';

class Address {
  final String cep;
  final String rua;
  final String numero;
  final String logradouro;
  final String estado;
  final String municipio;
  final Location location;

  Address({
    required this.cep,
    required this.rua,
    required this.numero,
    required this.logradouro,
    required this.estado,
    required this.municipio,
    required this.location,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      cep: json['cep'] ?? '',
      rua: json['rua'] ?? '',
      numero: json['numero'] ?? '',
      logradouro: json['logradouro'] ?? '',
      estado: json['estado'] ?? '',
      municipio: json['municipio'] ?? '',
      location: Location.fromJson(json['location']),
    );
  }
}
