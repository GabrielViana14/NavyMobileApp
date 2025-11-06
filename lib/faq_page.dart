import 'package:flutter/material.dart';

// Modelo de dados para um item do FAQ
class FaqItem {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});
}

class FaqPage extends StatelessWidget {
  FaqPage({super.key});

  // Lista de perguntas e respostas
  final List<FaqItem> _faqList = [
    FaqItem(
      question: 'Como posso redefinir minha senha?',
      answer:
          'Você pode redefinir sua senha na tela de login clicando em "Esqueci minha senha". Enviaremos um link de redefinição para o seu e-mail cadastrado.',
    ),
    FaqItem(
      question: 'O aplicativo é gratuito?',
      answer:
          'Sim, o download e o uso básico do aplicativo são totalmente gratuitos. Oferecemos uma versão "Premium" opcional com recursos adicionais.',
    ),
    FaqItem(
      question: 'Como entro em contato com o suporte?',
      answer:
          'Você pode nos enviar um feedback através da página "Feedback" no seu perfil, ou enviar um e-mail diretamente para suporte@meuapp.com.',
    ),
    FaqItem(
      question: 'Meus dados estão seguros?',
      answer:
          'Levamos a segurança a sério. Usamos criptografia de ponta a ponta para todas as comunicações e seus dados pessoais são armazenados de forma segura em nossos servidores.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perguntas Frequentes'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: _faqList.length,
        itemBuilder: (context, index) {
          final item = _faqList[index];
          // Usamos um Card para dar o mesmo efeito de sombra da tela de perfil
          return Card(
            elevation: 3, // Sombra suave
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ExpansionTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              title: Text(
                item.question,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    item.answer,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}