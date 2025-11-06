import 'package:flutter/material.dart';
import 'package:flutter_application_test/app_controller.dart';
import 'package:flutter_application_test/service/api_service.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Adicionei um AppBar para consistência
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        // Use a cor de fundo do tema
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.account_circle_outlined,
                    size: 70,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Alucinética Honorata",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Configuração",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              Container(
                // Removi a altura fixa para o conteúdo caber dinamicamente
                // height: 150.0,
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white, // Use Theme.of(context).cardColor
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Sombra mais suave
                      blurRadius: 8,
                      offset: const Offset(0, 4), // deslocamento da sombra
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Mudei para ListTile para um visual mais padrão
                    _buildConfigItem(
                      context,
                      icon: Icons.account_circle_sharp,
                      text: "Configuração de Conta",
                      onTap: () {
                        Navigator.of(context).pushNamed('/edit');
                      },
                    ),
                    _buildDivider(),
                    _buildConfigItem(
                      context,
                      icon: Icons.notifications_outlined, // Ícone diferente
                      text: "Configuração de notificação",
                      onTap: () {
                         // Você precisará criar esta página
                        // Navigator.of(context).pushNamed('/notifications');
                      },
                    ),
                    _buildDivider(),
                    _buildConfigItem(
                      context,
                      icon: Icons.feedback_outlined, // Ícone diferente
                      text: "Feedback",
                      onTap: () {
                        // Navega para a nova página
                        Navigator.of(context).pushNamed('/feedback');
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Outros",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              Container(
                // height: 110.0, // Removido
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                margin: const EdgeInsets.all(10.0),
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
                  children: [
                    _buildConfigItem(
                      context,
                      icon: Icons.info_outline, // Ícone diferente
                      text: "Sobre nós",
                      onTap: () {
                        // Navega para a nova página
                        Navigator.of(context).pushNamed('/about');
                      },
                    ),
                    _buildDivider(),
                    _buildConfigItem(
                      context,
                      icon: Icons.quiz_outlined, // Ícone diferente
                      text: "Perguntas Frequentes",
                      onTap: () {
                        // Navega para a nova página
                        Navigator.of(context).pushNamed('/faq');
                      },
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  print("Fazendo logoff");
                  await ApiService.deleteToken(); // Remove o token
                  await ApiService.deleteUserId(); // Se você estiver salvando o user_id também
                  AppController.instance.deslogar();
                  // Garante que o contexto é válido antes de navegar
                  if (!mounted) return;
                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                },
                child: Container(
                  width: double.infinity,
                  height: 50.0,
                  margin: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFED1836),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.exit_to_app_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Sair",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para criar os itens da lista
  Widget _buildConfigItem(BuildContext context,
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[600]),
      title: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_outlined,
          color: Colors.indigo, size: 18),
      onTap: onTap,
    );
  }

  // Widget auxiliar para o divisor
  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey[200],
      indent: 16,
      endIndent: 16,
    );
  }
}