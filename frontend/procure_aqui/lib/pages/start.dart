import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  initState(){
    super.initState();
    verifyToken().then((value){
      if(value){
        //Passa para outra pagina e exclui a pagina anterior
        Navigator.pushReplacementNamed(context, '/AppHome');
      }
      else{
        // Navigator.pushReplacementNamed(context, '/LoginPage');
        Navigator.pushReplacementNamed(context, '/');
      }
    });

  }

  Future<bool> verifyToken() async {
    //vai conferir se temos um token dentro do aplicativo
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    if(sharedPreference.getString('token') != null){
      return true;
    }
    else{
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()
      ),
    );
  }
}