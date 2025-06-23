import 'package:flutter/material.dart';
import 'package:flutter_application_test/models/carro_model.dart';
import 'package:flutter_application_test/service/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Future<List<CarroModel>> _carros;

  // Assim que abrir a tela vai procurar os carros
  @override
  void initState() {
    super.initState();
    _carros = ApiService.getCarros();
  }

  void recarregarCarros() {
    setState(() {
      _carros = ApiService.getCarros();
    });
  }


  double parsePreco(dynamic value) {
  if (value is int) return value.toDouble();
  if (value is double) return value;
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _carros, 
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar carros: ${snapshot.error}'));
          }

          final carros = snapshot.data!;

          return ListView.builder(
            itemCount: carros.length,
            itemBuilder: (context, index){
              final carro = carros[index];

              return ListViewCarItem(
                marca: carro.brand ?? 'Desconhecida', 
                titulo: carro.model ?? 'Desconhecida', 
                informacoes: carro.shortDescription ?? 'Desconhecida', 
                anoKilo: '${carro.year ?? '----'} - ${carro.mileage ?? 0}KM', 
                preco: double.tryParse((carro.pricePerHour ?? carro.price ?? 0).toString()) ?? 0.0,
                );
            }
            );
        }
        )
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
                  Flexible(
                      child: Text(
                        titulo.length > 15 ? '${titulo.substring(0, 15)}...' : titulo,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  const SizedBox(height: 4),
                  Flexible(
                    child: Text(
                      informacoes,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
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