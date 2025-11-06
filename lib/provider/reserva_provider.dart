import 'package:flutter/material.dart';
import 'package:flutter_application_test/models/reserva_model.dart'; // Corrija o import se necessário

class ReservaProvider with ChangeNotifier {
  ReservaModel? _reservaAtual;
  final List<ReservaModel> _historico = [];

  // ---- NOVO ----
  // 0 = Home, 1 = Mapa, 2 = Reservas, 3 = Perfil
  int _tabIndexParaMostrar = 0; 
  int get tabIndexParaMostrar => _tabIndexParaMostrar;
  // ---- FIM NOVO ----


  ReservaModel? get reservaAtual => _reservaAtual;
  List<ReservaModel> get historico => _historico;

  void criarReserva(ReservaModel novaReserva) {
    // Se já existia uma reserva ativa, move ela para o histórico (exemplo)
    if (_reservaAtual != null) {
      _historico.insert(0, _reservaAtual!);
    }
    
    _reservaAtual = novaReserva;
    
    // ---- NOVO ----
    // Ao criar uma reserva, mande o app para a aba "Reservas" (índice 2)
    _tabIndexParaMostrar = 2; 
    // ---- FIM NOVO ----
    
    // Avisa a MainPage (para trocar de aba) E a ReservaPage (para mostrar os dados)
    notifyListeners();
  }

  // ---- NOVO ----
  // Reseta a aba para "Home" (índice 0)
  void resetTab() {
    _tabIndexParaMostrar = 0;
  }

  void mudarTab(int novoIndex) {
    _tabIndexParaMostrar = novoIndex;
    notifyListeners();
  }
  // ---- FIM NOVO ----
}