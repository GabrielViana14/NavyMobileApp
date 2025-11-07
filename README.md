
![Navy App Logo](assets/logo/logo_navy_branco.png)
# Navy Mobile App

O aplicativo móvel oficial da Navy, desenvolvido em Flutter.

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white) ![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=Dart&logoColor=white)

## Sobre o Projeto:

Este repositório contém o código-fonte do aplicativo Navy Mobile. O objetivo é fornecer uma experiência de usuário fluida, rápida e nativa em dispositivos Android e iOS, utilizando o poder do Flutter.

## Funcionalidades

O aplicativo já conta com as seguintes funcionalidades: Autenticação: Sistema de Login e Logout seguro. Gerenciamento de Perfil: O usuário pode visualizar seus dados.

*   Configurações:
*   Configuração de Conta (Página /edit).
*   Configuração de Notificações.
*   Envio de Feedback.
*   Páginas de Informação:
*   Sobre Nós (com logo da empresa).
*   Perguntas Frequentes (FAQ).
*   Tema: Suporte a Tema Claro/Escuro (controlado pelo AppController).

## 🛠️ Tecnologias Utilizadas

Este projeto foi construído utilizando as seguintes tecnologias:

*   [Flutter](https://flutter.dev) - O SDK de UI do Google para criar belos aplicativos compilados nativamente.
*   [Dart](https://dart.dev) - A linguagem de programação otimizada para aplicativos em múltiplas plataformas.
*   shared\_preferences - Para persistência local de dados simples (como token de autenticação).
*   Gerenciamento de Estado Nativo - Utilizando
*   ChangeNotifier (AppController) para gerenciar o estado global (tema, login).

## Começando

Para executar este projeto localmente, siga os passos abaixo. Pré-requisitos Você precisa ter o Flutter SDK (versão 3.x ou superior) instalado. Um editor de código, como VS Code ou Android Studio. Um emulador de dispositivo ou um dispositivo físico. Instalação e Execução

1.  Clone o repositório:
   ```bash
   git clone https://github.com/GabrielViana14/NavyMobileApp
   ```  
5.  Navegue até o diretório do projeto:
   ```bash
    cd navy-mobile-app
   ```
7.  Instale as dependências:
   ```bash
    flutter pub get
   ```
9.  Execute o aplicativo:
   ```bash
    flutter run
   ```

## Estrutura do Projeto (Simplificada)

lib/  
├── main.dart # Ponto de entrada, rotas do app  
├── app\_controller.dart # Controlador de estado global (tema, login)  
│  
├── pages/ # Contém todas as telas (Widgets)  
│ ├── perfil\_page.dart  
│ ├── login\_page.dart  
│ ├── about\_us\_page.dart  
│ ├── faq\_page.dart  
│ ├── feedback\_page.dart  
│ └── ...  
│  
├── service/ # Lógica de negócios e serviços  
│ └── api\_service.dart # Simulação de API, SharedPreferences  
│  
assets/ # Imagens, fontes, etc.  
└── logo/  
└── logo\_navy\_colorido.png  

## Autores

- Felipe De Novais
- Gabriel Viana
- Geovanne Meloni
- Larissa Nunes

## Licença

Distribuído sob a licença MIT. Veja LICENSE para mais informações.
