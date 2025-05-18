import 'package:flutter/material.dart';
import 'app_controller.dart';




// StatelessWidget são paginas que podem ser alteradas enquanto rodam
class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int contador = 0;
  

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
      

      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            ListViewCarItem(
              marca: "Renault",
              titulo: "Renault chevete",
              informacoes: "infos vazadas", 
              anoKilo: '2003 - 0 KM', 
              preco: 1000.00,
            ),
            ListViewCarItem(
              marca: "Renault",
              titulo: "Renault chevete",
              informacoes: "infos vazadas", 
              anoKilo: '2003 - 0 KM', 
              preco: 1000.00,
            ),
            ListViewCarItem(
              marca: "Renault",
              titulo: "Renault chevete",
              informacoes: "infos vazadas", 
              anoKilo: '2003 - 0 KM', 
              preco: 1000.00,
            ),
            ListViewCarItem(
              marca: "Renault",
              titulo: "Renault chevete",
              informacoes: "infos vazadas", 
              anoKilo: '2003 - 0 KM', 
              preco: 1000.00,
            ),
            ListViewCarItem(
              marca: "Renault",
              titulo: "Renault chevete",
              informacoes: "infos vazadas", 
              anoKilo: '2003 - 0 KM', 
              preco: 1000.00,
            ),
            ListViewCarItem(
              marca: "Renault",
              titulo: "Renault chevete",
              informacoes: "infos vazadas", 
              anoKilo: '2003 - 0 KM', 
              preco: 1000.00,
            ),
            ListViewCarItem(
              marca: "Renault",
              titulo: "Renault chevete",
              informacoes: "infos vazadas", 
              anoKilo: '2003 - 0 KM', 
              preco: 1000.00,
            ),
          ],
        ),
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
                print("Abrir tela home");
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
                print("Abrir tela mapa");
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
                print("Abrir tela pesquisar");
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
                print("Abrir tela perfil");
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

class ListViewCarItem extends StatelessWidget {
  const ListViewCarItem({
    super.key, 
    required this.marca, 
    required this.titulo, 
    required this.informacoes, 
    required this.anoKilo, 
    required this.preco
    });

  final String marca;
  final String titulo;
  final String informacoes;
  final String anoKilo;
  final double preco;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 210.0,
        padding: EdgeInsets.all(12.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.7),
              blurRadius: 8,
              offset: Offset(0, 4), // deslocamento da sombra
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/placeholders/placeholder_carro.png',
                  width: 150,
                  height: 150,
                ),
              ],
            ),
            
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    marca,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Color(0xFF4444E8),
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    titulo,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),  
                  ),
                  Text(
                    informacoes,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  
                  Text(
                    anoKilo,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                      
                  Text(
                    "R\$ $preco",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        print('Item clicado');
      },
    );
  }
}