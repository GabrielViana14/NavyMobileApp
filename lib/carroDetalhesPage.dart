import 'package:flutter/material.dart';
import 'package:flutter_application_test/models/carro_model.dart';

class CarroDetalhesPage extends StatefulWidget {
  final CarroModel carro;

  const CarroDetalhesPage({super.key, required this.carro});

  @override
  State<CarroDetalhesPage> createState() => _CarroDetalhesPageState();
}

class _CarroDetalhesPageState extends State<CarroDetalhesPage> {
  int? tempoSelecionado = 1; // 1 = Definir tempo mínimo, 2 = Horas livres
  int dias = 0;
  int horas = 1;

  // Função para calcular preço
  double calcularPreco() {
    final precoHora = widget.carro.pricePerHour?? widget.carro.price;
    if (tempoSelecionado == 1) {
      return (dias * 24 + horas) * precoHora;
    } else if (tempoSelecionado == 2) {
      return 30 * 24 * precoHora; // exemplo: 1 mês = 30 dias
    } else {
      return 0;
    }
  }
  
  void incrementarDias() => setState(() => dias++);
  void decrementarDias() {
    if (dias > 0) setState(() => dias--);
  }

  void incrementarHoras() => setState(() => horas++);
  void decrementarHoras() {
    if (horas > 0) setState(() => horas--);
  }

  @override
  void initState() {
    super.initState();
    // Print do JSON completo do carro
    print(widget.carro.toJson());
  }

  @override
  Widget build(BuildContext context) {
    final carro = widget.carro;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personalize sua viagem',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagem do carro
            Center(
              child: carro.photoUrl != null && carro.photoUrl!.isNotEmpty
                  ? Image.network(
                      carro.photoUrl!,
                      height: 150,
                      errorBuilder: (context, error, stackTrace) {
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
            const SizedBox(height: 8),

            // Linha com marca, modelo e placa
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    '${carro.brand} ${carro.model}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4444E8),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // adiciona "..." se for maior que a largura
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  carro.license_plate ?? '',
                  style: TextStyle(fontSize: 24, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Card para definir tempo mínimo
            SizedBox(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
                margin: const EdgeInsets.all(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column( 
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Primeira coluna
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Definir tempo mínimo',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4444E8),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Escolha o tempo que deseja alugar",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                
                              ],
                            ),
                          ),

                          // Segunda coluna
                          Column(
                            children: [
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 1,
                                    groupValue: tempoSelecionado,
                                    onChanged: (value) {
                                      setState(() {
                                        tempoSelecionado = value;
                                      });
                                    },
                                  ),
                                  
                                ],
                              ),
                              
                            ],
                          ),
                          
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Primeira coluna de dias
                          Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: decrementarDias, 
                                    icon: Icon(Icons.remove),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '$dias',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  IconButton(
                                    onPressed: incrementarDias, 
                                    icon: Icon(Icons.add),
                                  )
                                ],
                              ),
                              Text(
                                  'Dia(s)',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                            ],
                          ),
                          // Segunda coluna de horas
                          Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => setState(() => horas--), 
                                    icon: Icon(Icons.remove),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '$horas',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  IconButton(
                                    onPressed: () => setState(() => horas++), 
                                    icon: Icon(Icons.add),
                                  )
                                ],
                              ),
                              Text(
                                  'Hora(s)',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      )
                    ]
                  ),
                ),
              ),
            ),

            // Card para tempo livre
            SizedBox(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
                margin: const EdgeInsets.all(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Primeira coluna
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Horas livres',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4444E8),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Use pelo tempo que quiser",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Segunda coluna com Radio
                      Column(
                        children: [
                          Row(
                            children: [
                              Radio<int>(
                                value: 2,
                                groupValue: tempoSelecionado,
                                onChanged: (value) {
                                  setState(() {
                                    tempoSelecionado = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'R\$ ${calcularPreco().toStringAsFixed(2)}',
              style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4444E8),
                  ),
            ),
            SizedBox(height: 16),

            // Card para detalhes do carro
            SizedBox(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
                margin: const EdgeInsets.all(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Primeira coluna
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Detalhes',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4444E8),
                              ),
                            ),
                            SizedBox(height: 4),
                            // Detalhes de Ano
                            Row(
                              children: [
                                const Icon(Icons.calendar_today, color: Color(0xFF4444E8)),
                                const SizedBox(width: 8),
                                Text(
                                  'Ano: ${carro.year}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Detalhes de Quilometragem
                            Row(
                              children: [
                                const Icon(Icons.speed, color: Color(0xFF4444E8)),
                                const SizedBox(width: 8),
                                Text(
                                  'Quilometragem: ${carro.mileage} km',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Detalhes de Placa
                            Row(
                              children: [
                                const Icon(Icons.credit_card, color: Color(0xFF4444E8)),
                                const SizedBox(width: 8),
                                Text(
                                  'Placa: ${carro.license_plate}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Detalhes de Preço por Hora
                            Row(
                              children: [
                                const Icon(Icons.access_time, color: Color(0xFF4444E8)),
                                const SizedBox(width: 8),
                                Text(
                                  'Preço por hora: R\$ ${carro.pricePerHour.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Detalhes de Preço de Compra
                            Row(
                              children: [
                                const Icon(Icons.monetization_on, color: Color(0xFF4444E8)),
                                const SizedBox(width: 8),
                                Text(
                                  'Preço de compra: R\$ ${carro.price.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            backgroundColor: const Color(0xFF4444E8),
          ),
          child: const Text(
            'Reservar Agora',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      )
    );
  }
}
