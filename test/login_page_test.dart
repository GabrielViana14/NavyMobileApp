import 'package:flutter/material.dart';
import 'package:flutter_application_test/loginPage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_test/service/api_service.dart';
import 'package:flutter_application_test/app_controller.dart';

import 'package:mocktail/mocktail.dart';

class MockApiService extends Mock implements ApiService {}
class MockAppController extends Mock implements AppController {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LoginPage Widget Test', () {
    late MockApiService mockApi;
    late MockAppController mockApp;

    setUp(() {
      mockApi = MockApiService();
      mockApp = MockAppController();
    });

    testWidgets('Renderiza os campos e botão corretamente', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginPage(),
        ),
      );

      // Verifica se os textos principais estão presentes
      expect(find.text('Usuário'), findsOneWidget);
      expect(find.text('Senha'), findsOneWidget);
      expect(find.text('Entrar'), findsOneWidget);
      expect(find.text('Cadastre-se'), findsOneWidget);
    });

    testWidgets('Preenche os campos e pressiona Entrar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginPage(),
        ),
      );

      final usuarioField = find.byType(TextField).at(0);
      final senhaField = find.byType(TextField).at(1);
      final entrarButton = find.text('Entrar');

      // Digita usuário e senha
      await tester.enterText(usuarioField, 'nome@email.com');
      await tester.enterText(senhaField, 'senha');

      // Pressiona botão
      await tester.tap(entrarButton);
      await tester.pump(); // Atualiza o estado

      // Verifica se os textos foram digitados
      expect(find.text('nome@email.com'), findsOneWidget);
      expect(find.text('senha'), findsOneWidget); 
    });

    testWidgets('Exibe SnackBar em erro de login', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: LoginPage(),
            ),
          ),
        ),
      );

      // Digita valores inválidos
      await tester.enterText(find.byType(TextField).at(0), 'invalido');
      await tester.enterText(find.byType(TextField).at(1), 'senhaerrada');

      // Pressiona botão
      await tester.tap(find.text('Entrar'));
      await tester.pump(const Duration(seconds: 5));

      // Verifica se o SnackBar aparece
      expect(find.byType(SnackBar), findsOneWidget); // se quiser mockar, pode simular erro
    });
  });
}
