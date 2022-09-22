import 'package:flutter/material.dart';

void main() {
  runApp(const ProcureAqui());
}

class ProcureAqui extends StatelessWidget {
  const ProcureAqui ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6200EE),
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(50, 100, 50, 50),
                child: Image.asset('lib/assets/images/logo2.png')
              ),
              Container(
                margin: EdgeInsets.all(50),
                child: Text("Seja bem vindo ao aplicativo Compre Aqui, o seu app de ofertas e comparação de preços de supermercados da sua região ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
                ),
                )
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                width: 220,
                height: 50,
                child: 
                  ElevatedButton(
                    child: Text('Entrar'),
                    onPressed: (){},
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      foregroundColor: MaterialStatePropertyAll(Colors.black)
                    ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                width: 220,
                height: 50,
                child: 
                  ElevatedButton(
                    child: Text("Cadastrar-se"),
                    onPressed: (){},
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      foregroundColor: MaterialStatePropertyAll(Colors.black)
                    ),
                  ) 
              ),
              Text(
                'Entrar sem cadastro',
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
