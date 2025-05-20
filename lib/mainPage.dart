import 'package:flutter/material.dart';
import 'package:flutter_application_test/homePage.dart';
import 'package:flutter_application_test/mapaPage.dart';
import 'package:flutter_application_test/perfilPage.dart';
import 'package:flutter_application_test/reservaPage.dart';
import 'app_controller.dart';




// StatelessWidget são paginas que podem ser alteradas enquanto rodam
class MainPage extends StatefulWidget{
  const MainPage({super.key});
  @override
  State<MainPage> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  int contador = 0;
  int _paginaSelecionada = 0;

  final List<Widget> _pages = [
    HomePage(),
    MapaPage(),
    ReservaPage(),
    PerfilPage(),
  ];

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ver linhas do layout: >flutter debug painter

      
      appBar: AppBar(
        title: Text(
          AppController.instance.isDarkTheme 
          ? 'Dark Theme'
          : 'Light Theme'
        ),
        actions: [
          Switch(
            value: AppController.instance.isDarkTheme, 
            onChanged: (value){
              AppController.instance.changeTheme();
            })
        ],

      ),
      

      body: IndexedStack(
        index: _paginaSelecionada,
        children: _pages,
      ),
      
      /*
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          setState(() { // Atualiza o estado
          contador++;
          });
      }),
      */

      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomAppBarButton(
              text: "Home",
              icone: Icons.home_outlined,
              funcao: () {
                setState(() => _paginaSelecionada = 0);
              },
              asset: 'assets/icon/bottom_appbar_home_icon.png',
            ),
            Container(
              width: 3,
              height: 46,
              color: Color(0xFF4444E8),
            ),
            BottomAppBarButton(
              text: "Mapa",
              icone: Icons.map_outlined,
              funcao: () {
                setState(() => _paginaSelecionada = 1);
              },
              asset: 'assets/icon/bottom_appbar_map_icon.png',
            ),
            Container(
              width: 3,
              height: 46,
              color: Color(0xFF4444E8),
            ),
            BottomAppBarButton(
              text: "Reservas",
              icone: Icons.search,
              funcao: () {
                setState(() => _paginaSelecionada = 2);
              },
              asset: 'assets/icon/bottom_appbar_reservas_icon.png',
            ),
            Container(
              width: 3,
              height: 46,
              color: Color(0xFF4444E8),
            ),
            BottomAppBarButton(
              text: "Perfil",
              icone: Icons.account_circle_outlined,
              funcao: () {
                setState(() => _paginaSelecionada = 3);
              },
              asset: 'assets/icon/bottom_appbar_perfil_icon.png',
            ),
          ],
        ),
      ),
    
    );
  }

}

class BottomAppBarButton extends StatelessWidget {
  const BottomAppBarButton({
    super.key, 
    required this.text, 
    required this.icone, 
    required this.funcao, 
    required this.asset,
  });
  final String asset;
  final String text;
  final IconData icone;
  final VoidCallback funcao;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: funcao,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            asset,
            width: 36,
            height: 36,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 14.0,
              color: AppController.instance.isDarkTheme 
              ? Color(0xFF3535B5)
              : Color(0xFF01017D), //light theme
              ),
          ),
        ],
      ),
    );
  }
}

