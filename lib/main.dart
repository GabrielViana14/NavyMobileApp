import 'package:flutter/material.dart';
import 'app.dart';
import 'package:provider/provider.dart'; // 1. Importe o provider
import 'package:flutter_application_test/provider/reserva_provider.dart';


void main(){
  runApp(
    ChangeNotifierProvider(
      create: (context) => ReservaProvider(), // 2. Crie o provider
      child: App(logado: false,)
    )
  );
}

