import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:procure_aqui/main.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  // @override
  // initState(){
  //   super.initState();
  // }

  bool connect = true;
  Future<bool> testConnect() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      }
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
    return false;
    
  }

  Future<void> _dialogBuilder(BuildContext context){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return _buildPopUpCard();
        }
    );
  }


  Widget _buildPopUpCard(){
    return Center(
      child: Card(
        child:  Container(
          padding: EdgeInsets.all(20),
          width: 375,
          height: 170,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xFF3700B3),
          ),
          child: Column(
            children: [
              Container(
                width: 320,
                child: Text(
                  'Você precisa de uma conexão a internet para acessar o sistema.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  child: Text('Tentar novamente'),
                  onPressed: (){
                    Navigator.of(context).pushReplacementNamed('/Start');
                  }, 
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  // Future<bool> verifyToken() async {
  //   //vai conferir se temos um token dentro do aplicativo
  //   SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  //   if(sharedPreference.getString('token') != null){
  //     return true;
  //   }
  //   else{
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                child: Text("Seja bem vindo ao aplicativo Procure Aqui, o seu app de ofertas e comparação de preços de supermercados da sua região ",
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
                    onPressed: (){
                      // testConnect().then((value) => connect = value);
                      // if(connect == true){
                        Navigator.of(context).popAndPushNamed(ProcureAqui.LoginPage);
                      // }else{
                      //   _dialogBuilder(context);
                      // }
                    },
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
                    onPressed: (){
                      // testConnect().then((bool value) => connect = value);
                      // if(connect == true){
                        Navigator.of(context).pushNamed(ProcureAqui.userForm);
                      // }else{
                      //   _dialogBuilder(context);
                      // }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      foregroundColor: MaterialStatePropertyAll(Colors.black)
                    ),
                  ) 
              ),
              TextButton(
                onPressed: (){
                  // testConnect().then((bool value) => connect = value);
                  // print(connect);
                  // if(connect == true){
                    Navigator.of(context).popAndPushNamed('/AppHome');
                  // }else{
                  //   _dialogBuilder(context);
                  // }
                },
                child: Text(
                  'Entrar sem cadastro',
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}