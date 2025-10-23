import 'package:flutter/material.dart';
import 'package:flutter_application_test/carroDetalhesPage.dart';
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
      body: FutureBuilder<List<CarroModel>>(
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
                carro: carro,
                );
            }
            );
        }
        )
    );
  }
}

class ListViewCarItem extends StatelessWidget {
  final CarroModel carro;
  const ListViewCarItem({
  super.key,
  required this.carro,
});

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
                SizedBox(
                  width: 150,
                  height: 150,
                  child: carro.photoUrl != null && carro.photoUrl!.isNotEmpty
                    ? Image.network(
                        carro.photoUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/placeholders/placeholder_carro.png');
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(child: CircularProgressIndicator());
                        },
                      )
                    : Image.asset('assets/placeholders/placeholder_carro.png'),
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
                    carro.brand,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Color(0xFF4444E8),
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Flexible(
                      child: Text(
                        carro.model.length > 15 ? '${carro.model.substring(0, 15)}...' : carro.model,
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
                      carro.shortDescription ?? '',
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
                    carro.year != null ? 'Ano: ${carro.year}' : 'Ano: N/A',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                      
                  Text(
                    "R\$ ${carro.pricePerHour}",
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarroDetalhesPage(carro: carro),
            )
        );
      },
    );
  }
}