import 'package:flutter/material.dart';

class tutorialPage extends StatelessWidget {
  const tutorialPage({super.key});

  Widget _customTextField(String text){
    return Container(
            margin: EdgeInsets.only(top: 20, left: 20),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6200EE),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 50),
                child: Text(
                  'Leitura de código de Barras',
                  style: TextStyle(
                    fontSize: 27,
                    color: Colors.white
                  ),
                )
              ),
            ),
            Center(
              child: Container(
              margin: EdgeInsets.only(top: 40),
              width: 150,
              height: 150,
              child: Image.asset(
                'lib/assets/images/iconTutorial.png',
              ),
              ),
            ),
            _customTextField('Tutorial:'),
            _customTextField('1 - Clique no ícone da camêra localizado no menu.'),
            _customTextField('2 - Encontre o código de barras do produto.'),
            _customTextField('3 - Aponte a camera do celular para o código de barras.'),
            _customTextField('4 - Deixe o celular estável ate a leitura ser realizada.'),
            _customTextField('5 - Prontinho, agora você ja pode cadastrar ou atualizar o preço do produto selecionado.'),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 30),
            )
          ],
        ),
      ),
    );
  }
}