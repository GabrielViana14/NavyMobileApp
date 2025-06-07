import 'package:flutter/material.dart';
import 'package:flutter_application_test/tab_main/homePage.dart';
import 'package:flutter_application_test/tab_main/mapaPage.dart';
import 'package:flutter_application_test/tab_main/perfilPage.dart';
import 'package:flutter_application_test/tab_main/reservaPage.dart';
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

      /*
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
      */

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
        height: kBottomNavigationBarHeight + 40,
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
              selecionado: _paginaSelecionada == 0,
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
              selecionado: _paginaSelecionada == 1,
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
              selecionado: _paginaSelecionada == 2,
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
              selecionado: _paginaSelecionada == 3,
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
    required this.asset, required this.selecionado,
  });
  final String asset;
  final String text;
  final IconData icone;
  final VoidCallback funcao;
  final bool selecionado;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: funcao,
      child: TweenAnimationBuilder(
        tween: Tween<double>(
          begin: 0,
          end: selecionado ? -10 : 0,
        ), 
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut, 
        builder: (context, value, child){
          return Transform.translate(
            offset: Offset(0, value),
            child: Column(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Image.asset(
                    asset,
                    key: ValueKey('$asset$selecionado'),
                    width: selecionado ? 42 : 36,
                    height: selecionado ? 42 : 36,
                    color: selecionado ? Color(0xFF01017D) : Color(0xFF3535B5),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF01017D)
                    ),
                ), 
              ],
            )
            );
        }
        )
    );
  }
}

