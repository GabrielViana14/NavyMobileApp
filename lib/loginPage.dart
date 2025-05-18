import 'package:flutter/material.dart';
import 'package:flutter_application_test/app_controller.dart';
import 'package:flutter_application_test/homePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  String usuario = '';
  String senha = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Fundo branco
          Container(color: Colors.white),

          // Gradiente com conteúdo
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFDEB8C1),
                    Color(0x42BF454E),
                    Color(0x669B3857),
                    Color(0xFF00007E),
                  ],
                  stops: [0.0, 0.15, 0.28, 0.78],
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Container(
                    width: 350,
                    height: 400,
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color(0xBDFFFFFF),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          onChanged: (value) {
                            usuario = value;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Usuário',
                            hintStyle: TextStyle(
                              fontSize: 20,
                              color: Color(0x8001017D),
                              fontWeight: FontWeight.w300,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF01017D),
                                width: 2.0
                              )
                            )
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                          onChanged: (value) {
                            senha = value;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Senha',
                            hintStyle: TextStyle(
                              fontSize: 20,
                              color: Color(0x8001017D),
                              fontWeight: FontWeight.w300,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF01017D),
                                width: 2.0
                              )
                            )
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            if( usuario.trim() == "teste" && senha.trim() == 'teste'){
                              print('correto');
                              AppController.instance.logar();
                            }else{
                              print('Incorreto');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Usuário ou senha incorretos"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xFFE35245),
                              borderRadius: BorderRadius.circular(25.0)
                            ),
                            child: Text(
                              "Entrar",
                              style: TextStyle(
                                fontSize: 26.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            print('abrir tela de lembrar senha');
                          },
                          child: Text(
                            'Esqueci minha senha',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFFFB5B4D),
                                fontWeight: FontWeight.w300,
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xFFFB5B4D)
                              ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            print('abrir tela de cadastro');
                          },
                          child: Container(
                            width: double.infinity,
                            height: 30,
                            margin: EdgeInsets.symmetric(horizontal: 60.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xFF413ED6),
                              borderRadius: BorderRadius.circular(25.0)
                            ),
                            child: Text(
                              "Cadastre-se",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 130,
                  ),
                  Image.asset(
                    'assets/logo/logo_navy_branco.png',
                    width: 200.0,
                    height: 200.0,
                  ),
                ],
              ), 
                  )
        ]
        ),
              )
            ),
          ),
        ],
      ),
    );

  }
}