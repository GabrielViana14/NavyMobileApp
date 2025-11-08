import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre Nós'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(  
                'assets/logo/logo_navy_colorido.png',
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 16),
              Text(
                'Navy',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Text(
                'Versão 1.0.0',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              const _InfoCard(
                title: 'Nossa Missão',
                content:
                    'O objetivo principal do projeto é desenvolver o Navy, um aplicativo inovador de locação de automóveis, com interface para dispositivos móveis e plataforma web, voltado a oferecer uma experiência prática, segura e descomplicada ao conectar locatários a empresas ou proprietários de veículos. Com um modelo diferenciado das locadoras tradicionais, o Navy funcionará sem lojas físicas, utilizando pontos estratégicos urbanos para retirada e devolução dos veículos, permitindo que o usuário inicie a locação em um local e finalize em outro.',
              ),
              const SizedBox(height: 20),
              const _InfoCard(
                title: 'Nossa Visão',
                content:
                    'A proposta do Navy é oferecer uma solução digital escalável, com usabilidade moderna e aderente à LGPD (Lei Geral de Proteção de Dados). Seu posicionamento é ser uma alternativa ágil, flexível e confiável para locação de automóveis no cenário urbano. O serviço será semelhante aos de aluguel de patinetes e bicicletas em grandes cidades, em que a devolução pode ser feita em um local diferente da retirada.',
              ),
              const SizedBox(height: 30),
              Text(
                '© 2025 Navy. Todos os direitos reservados.',
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget auxiliar para criar os cards de informação
class _InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const _InfoCard({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}