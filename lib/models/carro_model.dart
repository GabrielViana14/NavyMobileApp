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
      address: Address.fromJson(json['address']),
    );
  }
}
