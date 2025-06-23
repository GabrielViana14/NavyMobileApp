import 'package:flutter/material.dart';
import 'package:flutter_application_test/models/carro_model.dart';
import 'package:flutter_application_test/service/api_service.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';



class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => MapaPageState();
}

class MapaPageState extends State<MapaPage> {
  LatLng? _userLocation;
  final PopupController _popupController = PopupController();
  List<CarroModel> _carros = [];
  bool _mostrarInfo = false; // 👈 controla se a telinha aparece
  List<Marker> _userMarkers = [];
  List<Marker> _customMarkers = [];
  CarroModel? _carroSelecionado;




  @override
  void initState() {
    super.initState();
    _detectarLocalizacao();
    buscarCarros();
  }


  void buscarCarros () async{
    try {
      final carros = await ApiService.getCarros();
      setState(() {
        _carros = carros;
        _criarMarcadores();
      });
    }
    catch (e){
      print('Erro ao buscar carros: $e');
    }
  }

  void _criarMarcadores() {
    print("Total de carros recebidos: ${_carros.length}");
    _customMarkers = _carros.where((carro) {
      final loc = carro.address?.location;
      print('Checando carro: ${carro.brand} - localização: ${loc?.latitude}, ${loc?.longitude}');
      return loc != null && loc.latitude != 0.0 && loc.longitude != 0.0;
    }).map((carro) {
      final loc = carro.address!.location!;
      print('Criando marker para: ${carro.brand} em ${loc.latitude}, ${loc.longitude}');
      return Marker(
        width: 40,
        height: 40,
        point: LatLng(loc.latitude, loc.longitude),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _carroSelecionado = carro;
              _mostrarInfo = true;
            });
          },
          child: Icon(Icons.location_on, size: 40, color: Colors.red),
        ),
      );
    }).toList();
    print("Total de markers criados: ${_customMarkers.length}");
  }




  Future<void> _detectarLocalizacao() async {
    bool servicoAtivo;
    LocationPermission permissao;

    //Verifica se a localização está ativa
    servicoAtivo = await Geolocator.isLocationServiceEnabled();

    if(!servicoAtivo){
      print('Serviço desativado');
      return;
    }

    // Verifica permissão
    permissao = await Geolocator.checkPermission();
    if(permissao == LocationPermission.denied){
      permissao = await Geolocator.requestPermission();
      if(permissao == LocationPermission.denied){
        print("Permissão negada novamente");
        return;
      }
    }

    if(permissao == LocationPermission.deniedForever){
      print("Permissão de localização permanentemente negada");
      return;
    }

    // Pega a localização atual
    Position posicao = await Geolocator.getCurrentPosition();
    setState(() {
      _userLocation = LatLng(posicao.latitude, posicao.longitude);
      _userMarkers = [
        Marker(
          point: _userLocation!,
          width: 40,
          height: 40, 
          child: Icon(
           Icons.person_pin_circle, 
           size: 40, 
           color: Colors.blue 
           )
          ),  
        ];
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: LatLng(-23.55052, -46.633308) == null // mudar para localização do usuario ->_userLocation!
      ? const Center(child: CircularProgressIndicator())
      : Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: _carros.isNotEmpty
                  ? LatLng(_carros[0].address!.location!.latitude!, _carros[0].address!.location!.longitude!)
                  : LatLng(-23.55052, -46.633308),
              initialZoom: 10.0,
              onTap: (_,__){
                setState(() {
                  _mostrarInfo = false;
                });
              }
            ), 
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(markers: _userMarkers),
              MarkerLayer(markers: _customMarkers),
            ],
          ),
          if (_mostrarInfo && _carroSelecionado != null)
          Positioned(
            bottom: 10,
            left: 16,
            right: 16,
            child: AnimatedOpacity(
              opacity: 1,
              duration: Duration(milliseconds: 300),
              child: InfoCard(carro: _carroSelecionado!)
            ),
          ),

        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final CarroModel carro;

  const InfoCard({super.key, required this.carro});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: const Color(0xffA4A4A4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              carro.pricePerHour != null ? 'R\$ ${carro.pricePerHour} / hora' : 'Preço indisponível',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${carro.brand} - ${carro.year}',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              carro.shortDescription ?? '',
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
