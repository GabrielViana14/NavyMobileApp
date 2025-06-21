/// Modelo principal que representa um carro da sua API.
class CarroModel {
  final String id;
  final String? operationType;
  final int? pricePerHour;
  final String licensePlate;
  final String? status;
  final String? rentedAt;
  final String? soldAt;
  final String? shortDescription;
  final int? mileage;
  final Address? address;
  final String ownerId;
  final String model;
  final String brand;
  final int year;
  final String? color;
  final String? fuelType;
  final String? transmission;

  CarroModel({
    required this.id,
    this.operationType,
    this.pricePerHour,
    required this.licensePlate,
    this.status,
    this.rentedAt,
    this.soldAt,
    this.shortDescription,
    this.mileage,
    this.address,
    required this.ownerId,
    required this.model,
    required this.brand,
    required this.year,
    this.color,
    this.fuelType,
    this.transmission,
  });

  /// Construtor de fábrica para criar uma instância de [CarroModel] a partir de um JSON.
  /// Este método é responsável por mapear as chaves do JSON para as propriedades da classe.
  factory CarroModel.fromJson(Map<String, dynamic> json) {
    return CarroModel(
      id: json['_id'] as String,
      operationType: json['operationType'] as String?,
      pricePerHour: json['price_per_hour'] as int?,
      licensePlate: json['license_plate'] as String,
      status: json['status'] as String?,
      rentedAt: json['rented_at'] as String?,
      soldAt: json['sold_at'] as String?,
      shortDescription: json['short_description'] as String?,
      mileage: json['mileage'] as int?,
      // Se o campo 'address' no JSON não for nulo, cria um objeto Address a partir dele.
      address: json['address'] != null
          ? Address.fromJson(json['address'] as Map<String, dynamic>)
          : null,
      ownerId: json['owner_id'] as String,
      model: json['model'] as String,
      brand: json['brand'] as String,
      year: json['year'] as int,
      color: json['color'] as String?,
      fuelType: json['fuel_type'] as String?,
      transmission: json['transmission'] as String?,
    );
  }
}

/// Modelo que representa o endereço aninhado dentro do [CarroModel].
class Address {
  final String? cep;
  final String? rua;
  final String? numero;
  final String? logradouro;
  final String? estado;
  final String? municipio;
  final Location? location;

  Address({
    this.cep,
    this.rua,
    this.numero,
    this.logradouro,
    this.estado,
    this.municipio,
    this.location,
  });

  /// Construtor de fábrica para criar um [Address] a partir de um JSON.
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      cep: json['cep'] as String?,
      rua: json['rua'] as String?,
      numero: json['numero'] as String?,
      logradouro: json['logradouro'] as String?,
      estado: json['estado'] as String?,
      municipio: json['municipio'] as String?,
      // Se o campo 'location' não for nulo, cria um objeto Location.
      location: json['location'] != null
          ? Location.fromJson(json['location'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Modelo que representa a localização (latitude/longitude) aninhada dentro de [Address].
class Location {
  final double? latitude;
  final double? longitude;

  Location({
    this.latitude,
    this.longitude,
  });

  /// Construtor de fábrica para criar uma [Location] a partir de um JSON.
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      // Converte o valor numérico (int ou double) para double.
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }
}