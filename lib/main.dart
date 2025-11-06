import 'package:flutter/material.dart';
import 'app.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_test/provider/reserva_provider.dart';


void main(){
  runApp(
    ChangeNotifierProvider(
      create: (context) => ReservaProvider(), 
      child: App(logado: false,)
    )
  );
}

