import 'package:flutter/material.dart';
import 'package:flutter_application_test/models/carro_model.dart';
import 'package:flutter_application_test/models/reserva_model.dart';
import 'package:flutter_application_test/provider/reserva_provider.dart';
import 'package:provider/provider.dart';

class CarroConfirmacaoPage extends StatefulWidget {
  final CarroModel carro;
  final int dias;
  final int horas;
  final double valorTotal;
  final String tipoTempo;
  const CarroConfirmacaoPage({
    super.key, 
    required this.carro, 
    required this.dias, 
    required this.horas, 
    required this.valorTotal, required this.tipoTempo});

  @override
  State<CarroConfirmacaoPage> createState() => CarroConfirmacaoPageState();
}

class CarroConfirmacaoPageState extends State<CarroConfirmacaoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resumo da Reserva',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            // Nome e imagem do carro
            Row(
              children: [
                // Coluna 1: Textos
                Expanded(
                  flex: 7, // 70% da largura
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.carro.brand} ${widget.carro.model}',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Color(0xFF4444E8),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis, // adiciona "..." se for maior que a largura
                      ),
                      Text(
                        widget.carro.license_plate ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis, // adiciona "..." se for maior que a largura
                      ),
                      Text(
                        'Assinado por: ${widget.tipoTempo}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis, // adiciona "..." se for maior que a largura
                      ),
                    ],
                  )
                ),

                // Coluna 2: Imagem
                Expanded(
                  flex: 3, // 30% da largura
                  child: Column(
                    children: [
                      Center(
                        child: widget.carro.photoUrl.isNotEmpty
                            ? FadeInImage.assetNetwork(
                                placeholder: 'assets/placeholders/placeholder_carro.png',
                                image: widget.carro.photoUrl,
                                height: 150,
                                fit: BoxFit.cover,
                                imageErrorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/placeholders/placeholder_carro.png',
                                    height: 150,
                                  );
                                },
                              )
                            : Container(
                                height: 150,
                                color: Colors.grey[300],
                                child: Icon(
                                  Icons.directions_car,
                                  size: 50,
                                  color: Colors.grey[600],
                                ),
                              ),

                      ),
                    ],
                  )
                ),
              ],
            ),


            SizedBox(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
                margin: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Linha com fundo azul apenas atrás do texto
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 168, 219, 255), // fundo azul
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // padding só do texto
                      child: const Text(
                        'Onde pegar e devolver este carro:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    // Espaçamento e conteúdo interno do card
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.carro.address.cep.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.carro.address.rua}, Nº ${widget.carro.address.numero}, ${widget.carro.address.municipio} - ${widget.carro.address.estado}',
                                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'CEP: ${widget.carro.address.cep}',
                                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      widget.carro.address.logradouro,
                                      style: const TextStyle(fontSize: 16, color: Colors.black54),
                                    ),
                                  ],
                                )
                              : const Text(
                                  'Não se aplica para carros à venda',
                                  style: TextStyle(fontSize: 16, color: Colors.black54),
                                ),
                        ],
                      ),
                    ),



                  ],
                ),
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
                margin: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // linha 1
                          Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Valor total da reserva:',
                                      style: TextStyle(fontSize: 20, color: Colors.grey[800], fontWeight: FontWeight.bold,),
                                    ),
                                    Text(
                                      'Cobrado no ato da reserva:',
                                      style: TextStyle(fontSize: 14, color: Color(0xFF4444E8), fontWeight: FontWeight.bold,),
                                    ),
                                  ],
                                ),
                              ),

                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    Text(
                                      'R\$ ${widget.valorTotal.toStringAsFixed(2)}',
                                      
                                      style: TextStyle(fontSize: 20, color: Colors.grey[800], fontWeight: FontWeight.bold,),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          ////
                          const SizedBox(height: 8),
                          // linha 2

                          Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Valor caução:',
                                      style: TextStyle(fontSize: 20, color: Colors.grey[800], fontWeight: FontWeight.bold,),
                                    ),
                
                                  ],
                                ),
                              ),

                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    Text(
                                      'R\$ ${widget.valorTotal.toStringAsFixed(2)}',
                                      
                                      style: TextStyle(fontSize: 20, color: Colors.grey[800], fontWeight: FontWeight.bold,),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Text(
                            'Usado como garantia e devolvido no final da viagem:',
                            style: TextStyle(fontSize: 14, color: Color(0xFF4444E8), fontWeight: FontWeight.bold,),
                          ),



                          ////
                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
                margin: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'Valores cobrado ao final da viagem',
                            style: TextStyle(fontSize: 18, color: Color(0xFF4444E8), fontWeight: FontWeight.bold,),
                          ),

                          SizedBox(height: 12),

                          // linha 1
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Combustivel:',
                                      style: TextStyle(fontSize: 20, color: Colors.grey[800], fontWeight: FontWeight.bold,),
                                    ),
                                  ],
                                ),
                              ),

                              Expanded(
                                flex: 4,
                                child: Column(
                                  children: [
                                    Text(
                                      'R\$ ${widget.valorTotal.toStringAsFixed(2)}/km',
                                      
                                      style: TextStyle(fontSize: 20, color: Colors.grey[800], fontWeight: FontWeight.bold,),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          ////
                          const SizedBox(height: 8),
                          // linha 2

                          ////
                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Ação ao pressionar o botão de reservar

            // Criar o objeto ReservaModel a partir dos dados da tela
            final novaReserva = ReservaModel.fromConfirmacao(
              carro: widget.carro,
              dias: widget.dias,
              horas: widget.horas,
              valorTotal: widget.valorTotal,
              tipoTempo: widget.tipoTempo,
            );

            // Chamar o provider para "salvar" esta reserva
            Provider.of<ReservaProvider>(context, listen: false)
             .criarReserva(novaReserva);

            // Voltar para a tela principal (MainPage)
            Navigator.of(context).pop();
            Navigator.of(context).pop();


          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            backgroundColor: const Color(0xFF4444E8),
          ),
          child: const Text(
            'Ir para pagamento',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      )
    );
  }
}