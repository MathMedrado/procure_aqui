import 'package:flutter/material.dart';
import 'package:procure_aqui/components/HomePage.dart';
import 'package:procure_aqui/main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();

  //final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //Conversar sobre com o Luis e Mateus
      backgroundColor: Color(0xFF6200EE),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(50, 250, 50, 50),
            child: Image.asset('lib/assets/images/logo2.png')
          ),
          Container(
            height: 50,
            width: 330,
            margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.white
            ),
            child: 
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Digite o seu email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  )
                ),
              )
          ),
          Container(
            height: 50,
            width: 330,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.white
            ),
            child: 
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Digite o seu email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  )
                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(200, 0, 0, 0),
            child: TextButton(
              onPressed: (){
                Navigator.of(context).pushNamed(ProcureAqui.ForgetPassword);
              }, 
              child: Text(
                  'Esqueceu a senha?',
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline
                  ),
                )
              ),
          ),
          Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                width: 220,
                height: 50,
                child: 
                  ElevatedButton(
                    child: Text(
                      'Entrar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                    onPressed: (){},
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      foregroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                ),
              ),
        ],      
      ),
    );
  }
}