import 'package:flutter/material.dart';
import 'package:flutter_application_test/chatPage.dart';
import 'package:flutter_application_test/tab_main/homePage.dart';
import 'package:flutter_application_test/tab_main/mapaPage.dart';
import 'package:flutter_application_test/tab_main/perfilPage.dart';
import 'package:flutter_application_test/tab_main/reservaPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_test/provider/reserva_provider.dart';



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

  final GlobalKey<HomePageState> _homePageKey = GlobalKey<HomePageState>();
  final GlobalKey<MapaPageState> _mapPageKey = GlobalKey<MapaPageState>();
  

  List<Widget> get _pages => [
    HomePage(key: _homePageKey),
    MapaPage(key: _mapPageKey),
    ReservaPage(),
    PerfilPage(),
  ];

  

  @override
  Widget build(BuildContext context) {

    // reconstruída e o código abaixo será executado.
    final tabIndex = context.watch<ReservaProvider>().tabIndexParaMostrar;

    if (tabIndex != _paginaSelecionada) {
      // Usa um "post-frame callback" para chamar o setState DEPOIS
      // que o build terminar, evitando erros.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _paginaSelecionada = tabIndex;
        });
      });
    }


    
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

      body: Stack(
        children: [
          IndexedStack(
            index: _paginaSelecionada,
            children: _pages,
          ),
          Align(
            alignment: Alignment.centerLeft, // Posição: centro-esquerda
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0), // Um pequeno espaço da borda
              child: FloatingActionButton(
                mini: true, // Botão pequeno
                heroTag: 'chat_fab', // Tag única para evitar conflitos de animação
                onPressed: () {
                  // Ação de clique: navegar para a ChatPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatPage()),
                  );
                },
                backgroundColor: Colors.white, // Cor do seu app
                child: const Icon(Icons.chat_bubble_outline),
              ),
            ),
          ),

        ],
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
                Provider.of<ReservaProvider>(context, listen: false).mudarTab(0);
                setState((){
                  _paginaSelecionada = 0;

                   // força recarregar os carros
                   _homePageKey.currentState?.recarregarCarros();
                  
                  });
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
                Provider.of<ReservaProvider>(context, listen: false).mudarTab(1);
                setState(() {
                  _paginaSelecionada = 1;
                  _mapPageKey.currentState?.buscarCarros();
                });
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
                Provider.of<ReservaProvider>(context, listen: false).mudarTab(2);
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
                Provider.of<ReservaProvider>(context, listen: false).mudarTab(3);
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

