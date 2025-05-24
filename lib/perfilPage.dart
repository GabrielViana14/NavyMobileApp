import 'package:flutter/material.dart';
import 'package:flutter_application_test/app_controller.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
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
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                  ),
                ),
              ]
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Configuração",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),
            ),
            Container(
              height: 150.0,
              padding: EdgeInsets.all(12.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.7),
                    blurRadius: 8,
                    offset: Offset(0, 4), // deslocamento da sombra
                  ),
                ],
              ),
              child: Column(
                children: [
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.account_circle_sharp,
                          color: Colors.grey,
                        ),
                        Text(
                          "Configuração de Conta",
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 16
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.indigo,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.account_circle_sharp,
                          color: Colors.grey,
                        ),
                        Text(
                          "Configuração de notificação",
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 16
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.indigo,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.account_circle_sharp,
                          color: Colors.grey,
                        ),
                        Text(
                          "Feedback",
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 16
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.indigo,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Outros",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),
            ),
            Container(
              height: 110.0,
              padding: EdgeInsets.all(12.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.7),
                    blurRadius: 8,
                    offset: Offset(0, 4), // deslocamento da sombra
                  ),
                ],
              ),
              child: Column(
                children: [
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.account_circle_sharp,
                          color: Colors.grey,
                        ),
                        Text(
                          "Sobre nós",
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 16
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.indigo,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.account_circle_sharp,
                          color: Colors.grey,
                        ),
                        Text(
                          "Perguntas Frequentes",
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 16
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.indigo,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),
            GestureDetector(
              onTap: (){
                print("Fazendo logoff");
                AppController.instance.deslogar();
              },
              child: Container(
                width: double.infinity,
                height: 50.0,
                margin: EdgeInsets.all(20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFFED1836),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                        color: Colors.white
                      ),
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}