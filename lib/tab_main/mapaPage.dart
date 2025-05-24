import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';



class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  LatLng? _userLocation;

  @override
  void initState() {
    super.initState();
    _detectarLocalizacao();
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
    });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LatLng(-23.55052, -46.633308) == null // mudar para localização do usuario ->_userLocation!
      ? const Center(child: CircularProgressIndicator())
      : FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(-23.55052, -46.633308), // São paulo -> LatLng(-23.55052, -46.633308) - mudar para localização do usuario ->_userLocation!
          initialZoom: 13.0, 
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            userAgentPackageName: 'com.exemplo.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(-23.55052, -46.633308), // mudar para localização do usuario ->_userLocation!
                width: 80,
                height: 80,
                child: Image.asset('assets/icon/marker_navy_icon.png'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}