import 'package:flutter/material.dart';
import 'app.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_test/provider/reserva_provider.dart';
import 'package:flutter_application_test/app_controller.dart'; 


Future<void> main() async{
  // Garanta que os bindings do Flutter sejam inicializados
  WidgetsFlutterBinding.ensureInitialized();

  //    Isso vai atualizar AppController.instance.logado
  await AppController.instance.loadFromStorage();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ReservaProvider(), 
      // Passa o valor de login que foi carregado da memória
      child: App(logado: AppController.instance.logado,)
    )
  );
}

