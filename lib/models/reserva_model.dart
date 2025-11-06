import 'package:flutter_application_test/models/carro_model.dart';

enum StatusReserva { pendente, ativa, finalizada }

class ReservaModel {
  final CarroModel carro;
  final int dias;
  final int horas;
  final double valorTotal;
  final String tipoTempo;
  final StatusReserva status;

  ReservaModel({
    required this.carro,
    required this.dias,
    required this.horas,
    required this.valorTotal,
    required this.tipoTempo,
    this.status = StatusReserva.pendente, // Começa como pendente
  });

  // Constrói o modelo a partir dos dados da tela de confirmação
  factory ReservaModel.fromConfirmacao({
    required CarroModel carro,
    required int dias,
    required int horas,
    required double valorTotal,
    required String tipoTempo,
  }) {
    return ReservaModel(
      carro: carro,
      dias: dias,
      horas: horas,
      valorTotal: valorTotal,
      tipoTempo: tipoTempo,
    );
  }
}