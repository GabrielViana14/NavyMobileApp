import 'package:flutter/material.dart';
import 'package:flutter_application_test/cadastroPage.dart';
import 'package:flutter_application_test/editPage.dart';
import 'package:flutter_application_test/loginPage.dart';
import 'app_controller.dart';
import 'mainPage.dart';

// StatelessWidget são paginas estaticas
class App extends StatelessWidget{
  const App({super.key, required this.logado});

  //'final' são variáveis que não podem ser alteradas 
  //depois de serem inicializadas
  final bool logado ;
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: AppController.instance ,builder: (context, child) {
      return MaterialApp(
      theme: ThemeData(
        //Cor Hex = 0xFF + Color
        //Ex: Hex:#3535B5  Color(0xFF3535B5)

        // Tema do aplicativo
        brightness: AppController.instance.isDarkTheme 
          ? Brightness.dark // Tema escuro
          : Brightness.light, // Tema Claro

        // Cor primária (para AppBar, FloatingActionButton, etc.)
        primaryColor: AppController.instance.isDarkTheme 
          ? Color(0xFF3535B5) // Tema escuro
          : Color(0xFFFB5B4D),

        // Swatch para componentes baseados em Material
        primarySwatch: AppController.instance.isDarkTheme 
        ? Colors.deepOrange 
        : Colors.indigo,

        // Cor do plano de fundo da Scaffold
        scaffoldBackgroundColor: AppController.instance.isDarkTheme 
        ? Colors.black38
        : Colors.white,

        // Estilo da AppBar
        appBarTheme: AppBarTheme(
          backgroundColor: AppController.instance.isDarkTheme 
                            ? Color(0xFFFB5B4D) 
                            : Color(0xFFFFFFFF),
          foregroundColor: AppController.instance.isDarkTheme 
                            ? Color(0xFF3535B5) 
                            : Color(0xFF01017D), // texto e ícones
        ),

        // Estilo dos botões
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF3535B5), // cor do botão
            foregroundColor: Colors.white, // cor do texto
          ),
        ),

         // Estilo do texto geral
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black87),
        ),

        // Cor dos ícones
        iconTheme: IconThemeData(
          color: AppController.instance.isDarkTheme 
          ? Color(0xFF3535B5) 
          : Color(0xFFFB5B4D),
          size: 36,
        ),

        // Estilo da BottomAppBar
        bottomAppBarTheme: BottomAppBarTheme(
          color: AppController.instance.isDarkTheme 
          ? Color(0xFFFB5B4D)
          : Color(0xFFFFFFFF), //light theme
        ),

      ),
      initialRoute:  AppController.instance.logado ? '/main' : '/login',
      routes: {
        '/main' : (context) => MainPage(),
        '/login' : (context) => LoginPage(),
        '/cadastro': (context) => cadastroPage(),
        '/edit': (context) => EditPage(),
      },
    );
    },
    );
  }
}