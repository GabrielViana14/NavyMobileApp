import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_application_test/app_controller.dart'; 

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  // Variáveis para o AppController e o MockStorage
  late AppController appController;
  late MockFlutterSecureStorage mockStorage;

  setUp(() {
    // Inicializa o AppController e o MockStorage antes de cada teste
    appController = AppController();
    mockStorage = MockFlutterSecureStorage();
    
    // Injete o mockStorage no AppController
    appController.storage = mockStorage;

  });

  // Grupo de testes
  group('AppController Tests', () {

    test('Valores iniciais devem estar como false', () {
      expect(appController.logado, false);
      expect(appController.isDarkTheme, false);
    });

    test('changeTheme deve mudar o isDarkTheme e notificar os listeners', () {
      int listenerCount = 0;
      appController.addListener(() => listenerCount++);

      appController.changeTheme();

      expect(appController.isDarkTheme, true);
      expect(listenerCount, 1, reason: "notifyListeners() should be called once");

      appController.changeTheme();
      
      expect(appController.isDarkTheme, false);
      expect(listenerCount, 2, reason: "notifyListeners() should be called again");
    });

    test('logar deve set logado to true, salvar no storage, e notify listeners', () async {
      // Quando 'write' for chamado com 'key: logado' e 'value: true', retorne um Future vazio.
      when(() => mockStorage.write(key: 'logado', value: 'true')).thenAnswer((_) => Future.value());

      int listenerCount = 0;
      appController.addListener(() => listenerCount++);

      await appController.logar();

      expect(appController.logado, true);
      // Verifique se o método 'write' do mock foi chamado exatamente 1 vez com os args corretos
      verify(() => mockStorage.write(key: 'logado', value: 'true')).called(1);
      expect(listenerCount, 1);
    });

    test('deslogar deve alterar logado para false, salvar no storage, e notificar os listeners', () async {
      // Simule um estado inicial "logado" para garantir que o deslogar funcione
      when(() => mockStorage.write(key: 'logado', value: 'true')).thenAnswer((_) => Future.value());

      await appController.logar(); // Isso chamará o mock, vamos resetá-lo

      reset(mockStorage); // Reseta contagens de chamadas do mock

      when(() => mockStorage.write(key: 'logado', value: 'false')).thenAnswer((_) => Future.value());
      
      int listenerCount = 0;
      appController.addListener(() => listenerCount++);

      await appController.deslogar();

      expect(appController.logado, false);
      verify(() => mockStorage.write(key: 'logado', value: 'false')).called(1);
      expect(listenerCount, 1);
    });

    test('loadFromStorage deve ler "true" e set logado para true', () async {

      when(() => mockStorage.read(key: 'logado')).thenAnswer((_) async => 'true');

      await appController.loadFromStorage();

      expect(appController.logado, true);
      verify(() => mockStorage.read(key: 'logado')).called(1);
    });

    test('loadFromStorage deve ler "false" e set logado para false', () async {

      when(() => mockStorage.read(key: 'logado')).thenAnswer((_) async => 'false');

      await appController.loadFromStorage();

      expect(appController.logado, false);
    });

    test('loadFromStorage deve ler null e set logado para false', () async {

      when(() => mockStorage.read(key: 'logado')).thenAnswer((_) async => null);

      await appController.loadFromStorage();

      expect(appController.logado, false);
    });

  });
}