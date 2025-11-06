import 'package:flutter/material.dart';
import 'package:flutter_application_test/models/reserva_model.dart';
import 'package:flutter_application_test/provider/reserva_provider.dart';
import 'package:provider/provider.dart';

class ReservaPage extends StatefulWidget {
  const ReservaPage({super.key});

  @override
  State<ReservaPage> createState() => _ReservaPageState();
}

// Adicionamos 'TickerProviderStateMixin' para a animação do TabController
class _ReservaPageState extends State<ReservaPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool _isLocked = true; // Estado para controlar o botão de trancar

  @override
  void initState() {
    super.initState();
    // Inicializa o TabController com 2 abas
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose(); // Limpa o controller ao sair da tela
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ---- CORREÇÃO AQUI ----
    // Removemos o Scaffold e o 'body:'.
    // A página agora retorna a Column diretamente.
    final reservaProvider = context.watch<ReservaProvider>();
    final ReservaModel? reservaAtual = reservaProvider.reservaAtual;
    final List<ReservaModel> historico = reservaProvider.historico;


    return Column(
      children: [
        // 1. O Search Bar do seu wireframe
        _buildSearchBar(context),

        // 2. O controlador das abas (Tabs)
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Reserva atual'),
            Tab(text: 'Histórico Reserva'),
          ],
          // Cores para destacar a aba ativa
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Theme.of(context).primaryColor,
        ),

        // 3. O conteúdo de cada aba
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Aba 1: Reserva Atual
              _buildReservaAtual(context, reservaAtual),
              
              // Aba 2: Histórico
              _buildHistorico(context, historico),
            ],
          ),
        ),
      ],
    );
    // ---- FIM DA CORREÇÃO ----
  }

  /// Constrói o SearchBar do topo
  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8), 
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Aeroporto, Estado, Endereço',
          suffixIcon: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.search, color: Colors.grey[600]),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
    );
  }

  /// Constrói o conteúdo da aba "Reserva Atual"
  Widget _buildReservaAtual(BuildContext context, ReservaModel? reservaAtual) {

    // Se NÃO HÁ reserva, mostra uma mensagem
    if (reservaAtual == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Você não possui nenhuma reserva ativa no momento.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    // Se HÁ uma reserva, mostra os dados dela
    final carro = reservaAtual.carro; // Pega o carro de dentro da reserva
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Informações do Carro (Vindas do 'reservaAtual.carro')
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      // Dado Dinâmico
                      carro.photoUrl.isNotEmpty 
                        ? carro.photoUrl 
                        : 'https://placehold.co/120x80/e0e0e0/9e9e9e?text=Carro', // URL placeholder
                      width: 120,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(
                          width: 120,
                          height: 80,
                          color: Colors.grey[200],
                          child: const Icon(Icons.directions_car, size: 40, color: Colors.grey)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // Dado Dinâmico
                          '${carro.brand} ${carro.model}', 
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          // Dado Dinâmico
                          'Placa: ${carro.license_plate ?? 'N/A'}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 32),

              // 2. Detalhes da Reserva (Vindos do 'reservaAtual.carro.address')
              _buildDetalheReserva(
                context,
                icon: Icons.location_on, // Ícone de "pegar"
                title: 'Local de Retirada',
                // Dados Dinâmicos
                subtitle: '${carro.address.rua}, ${carro.address.numero}',
                data: '${carro.address.municipio} - ${carro.address.estado}',
              ),
              const SizedBox(height: 16),
              _buildDetalheReserva(
                context,
                icon: Icons.flag, // Ícone de "devolver"
                title: 'Local de Devolução',
                // Dados Dinâmicos (assumindo que é o mesmo local)
                subtitle: '${carro.address.rua}, ${carro.address.numero}',
                // TODO: Você vai querer guardar a data de devolução na ReservaModel
                data: 'Devolução: ${reservaAtual.dias} dias, ${reservaAtual.horas} horas',
              ),
              const Divider(height: 32),

              // 3. Ação Principal (Trancar/Destrancar)
              ElevatedButton.icon(
                icon: Icon(_isLocked ? Icons.lock_open : Icons.lock),
                label: Text(_isLocked ? 'DESTRANCAR' : 'TRANCAR'),
                onPressed: () {
                  setState(() {
                    _isLocked = !_isLocked;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  backgroundColor: _isLocked
                      ? Theme.of(context).primaryColor
                      : Colors.grey[700],
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              // 4. Ações Secundárias
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAcaoSecundaria(context, icon: Icons.map, label: 'Navegar'),
                  _buildAcaoSecundaria(context, icon: Icons.add_alarm, label: 'Extender'),
                  _buildAcaoSecundaria(context, icon: Icons.warning_amber, label: 'Reportar'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  /// Widget auxiliar para os detalhes de Retirada/Devolução
  Widget _buildDetalheReserva(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required String data}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Theme.of(context).primaryColor, size: 30),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(subtitle, style: const TextStyle(fontSize: 16)),
              Text(data, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }

  /// Widget auxiliar para os botões de ação secundários
  Widget _buildAcaoSecundaria(BuildContext context,
      {required IconData icon, required String label}) {
    return InkWell( // Adiciona feedback de toque
      onTap: () { /* Ação do botão */ },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor, size: 28),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: Theme.of(context).primaryColor)),
          ],
        ),
      ),
    );
  }

  /// Constrói o conteúdo da aba "Histórico" (Placeholder)
  Widget _buildHistorico(BuildContext context, List<ReservaModel> historico) {

    // Se o histórico está vazio, mostra uma mensagem
    if (historico.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Seu histórico de reservas está vazio.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }
    
    // Se HÁ histórico, mostra a lista
    return ListView.builder(
      itemCount: historico.length,
      itemBuilder: (context, index) {
        final item = historico[index]; // Pega o item real do provider
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.directions_car, color: Colors.grey),
            // Dados Dinâmicos
            title: Text('${item.carro.brand} ${item.carro.model}'),
            // Dados Dinâmicos
            subtitle: Text('Plano: ${item.tipoTempo}'),
            // Dados Dinâmicos
            trailing: Text(
              'R\$ ${item.valorTotal.toStringAsFixed(2)}', 
              style: const TextStyle(fontWeight: FontWeight.bold)
            ),
            onTap: () {
              // Navegaria para a página de detalhes do histórico
            },
          ),
        );
      },
    );
  }
}