import 'package:flutter_application_test/models/address_model.dart';

class CarroModel {
  final String id;
  final String brand;
  final String model;
  final String shortDescription;
  final int year;
  final int mileage;
  final double price;
  final double pricePerHour;
  final Address address;
  final String photoUrl; // Adicionando o campo photoUrl

  CarroModel({
    required this.id,
    required this.brand,
    required this.model,
    required this.shortDescription,
    required this.year,
    required this.mileage,
    required this.price,
    required this.pricePerHour,
    required this.address,
    required this.photoUrl,
  });

  factory CarroModel.fromJson(Map<String, dynamic> json) {
    return CarroModel(
      id: json['_id'],
      brand: json['brand'],
      model: json['model'],
      shortDescription: json['short_description'] ?? '',
      year: json['year'] ?? 0,
      mileage: json['mileage'] ?? 0,
      price: double.tryParse(json['price']?.toString() ?? '') ?? 0.0,
      pricePerHour: double.tryParse(json['price_per_hour']?.toString() ?? '') ?? 0.0,
      address: json['address'] != null
        ? Address.fromJson(json['address'] as Map<String, dynamic>)
        : Address.empty(), // ou outra forma de criar um endereço padrão
      photoUrl: json['photo_url'] ?? '', // Acessando o campo photoUrl
    );
  }
}
