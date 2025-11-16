import 'package:flutter/material.dart';
import 'dart:async'; // Para o Future.delayed

// Classe simples para representar uma mensagem
class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  // Inicializa a lista de mensagens com as boas-vindas.
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Olá! Este é o seu assistente de busca.",
      isUser: false,
    ),
    ChatMessage(
      text: "Digite o que você procura (ex: 'carros elétricos', 'SUV 7 lugares', 'sedan automático até 100.000').",
      isUser: false,
    ),
    ChatMessage(
      text: "Eu retornarei os melhores resultados para você!",
      isUser: false,
    ),
  ];
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    final text = _controller.text;
    if (text.isEmpty) return;

    // Adiciona a mensagem do usuário
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _isLoading = true;
    });

    _controller.clear();
    _scrollToBottom();

    // --- SIMULAÇÃO DE CHAMADA DE API ---
    // Substitua esta parte pela sua chamada de API real (http, dio, etc.)
    try {
      // Simula um atraso de rede
      await Future.delayed(const Duration(seconds: 1));

      // Resposta simulada da API
      final String apiResponse = "Esta é uma resposta da API para: '$text'";

      setState(() {
        _messages.add(ChatMessage(text: apiResponse, isUser: false));
      });
    } catch (e) {
      // Trata um erro
      setState(() {
        _messages.add(ChatMessage(text: "Erro: Não foi possível conectar.", isUser: false));
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
      _scrollToBottom();
    }
    // --- FIM DA SIMULAÇÃO ---
  }

  void _scrollToBottom() {
    // Garante que o scroll aconteça depois que o widget for construído
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0, 
        foregroundColor: const Color(0xFF01017D), 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
        title: const Text('AutoFilter AI Chat'),
      ),
      body: Column(
        children: [
          // Lista de mensagens
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          // Indicador de "digitando..."
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 8),
                  Text("Assistente está digitando..."),
                ],
              ),
            ),
          // Input de texto
          _buildInputArea(),
        ],
      ),
    );
  }

  // Widget para a bolha de mensagem
  Widget _buildMessageBubble(ChatMessage message) {
    final alignment = message.isUser ? Alignment.centerRight : Alignment.centerLeft;
    final color = message.isUser ? const Color(0xFF3535B5) : Colors.grey[300];
    final textColor = message.isUser ? Colors.white : Colors.black87;

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          message.text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  // Widget para a área de input
  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: 'Digite sua mensagem...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onSubmitted: (_) => _isLoading ? null : _sendMessage(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Color(0xFF01017D)),
            onPressed: _isLoading ? null : _sendMessage, // Desativa enquanto carrega
          ),
        ],
      ),
    );
  }
}