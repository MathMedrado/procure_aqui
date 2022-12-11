import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:procure_aqui/pages/HomePage.dart';
import 'package:procure_aqui/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final snackBar = SnackBar(content: Text('Email ou senha incorretos!', textAlign: TextAlign.center), backgroundColor: Colors.red,);
  bool showSnackBar = false;

  _submitLogin(){
    final email = _emailController.text;
    final password = _passwordController.text;

    print(email);
    print(password);
  }

  Future<bool> login() async{
    //vai setar o nosso token
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse('http://18.208.163.221/token/');
    var response = await http.post(url,
    body: {
      'email' : _emailController.text,
      'password' : _passwordController.text
      }
    );
    var userEmail = _emailController.text;
    var userUrl = Uri.parse('http://18.208.163.221/users/filter/$userEmail');
    var responseUser = await http.get(userUrl);
    //print(responseUser.statusCode);
    //print(jsonDecode(responseUser.body)['username']);

/*
    if(responseUser.statusCode == 200){
      await sharedPreferences.setString('userEmail', jsonDecode(responseUser.body)['username']);
      print(jsonDecode(responseUser.body)['username']);
      return true;
    }
    else{
      print(response.body);
      print(response.statusCode);
      //print(jsonDecode(response.body));
      print('erro');
      return false;
    }
*/
    //try{
      //var jsonobj = jsonDecode(response.body);
      //print(jsonobj);
   // }catch(e){
      //print(e);
    //}

    if(response.statusCode == 200){
      await sharedPreferences.setString('token', jsonDecode(response.body)['access']);
      await sharedPreferences.setString('email', _emailController.text);
      print(jsonDecode(response.body)['access']);
      print(sharedPreferences.getString('email'));
      return true;
    }
    else{
      print(response.body);
      print(response.statusCode);
      //print(jsonDecode(response.body));
      print('erro');
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false, //Conversar sobre com o Luis e Mateus
        backgroundColor: Color(0xFF6200EE),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(50, 100, 50, 50),
                //child: Image.asset('lib/assets/images/logo2.png')
                child: Image.asset('lib/assets/images/novologo.png')

              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 330,
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: Colors.white
                      ),
                      child: 
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Digite o seu email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            )
                          ),
                        //   validator: (email){
                        //     if(email == null || email.isEmpty){
                        //       return 'Digite o seu email!';
                        //     }
                        //     else if (!RegExp(
                        //       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        //     .hasMatch(_emailController.text)) {
                        //   return 'Digite um e-mail valido!';
                        //   }
                        // }
                        ),
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
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Digite a sua senha',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            )
                          ),
                          // validator: (password){
                          //   if(password == null || password.isEmpty){
                          //     return 'Você precisa informar a sua senha.';
                          //     return '';
                          //   }else if(password.length < 5){
                          //     return 'A sua Senha precisa conter no minimo 10 caracteres';
                          //   }
                          // },
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(200, 0, 0, 0),
                      child: TextButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed(ProcureAqui.ForgetPassword);
                        }, 
                        child: const Text(
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
                              child: const Text(
                                'Entrar',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                                ),
                              ),
                              onPressed: () async {
                                // _submitLogin();
                                // Navigator.of(context).pushNamed(ProcureAqui.userProfilePage);
                                // Navigator.of(context).pushNamed('/AppHome');
                                //pega a referencia do  teclado
                                FocusScopeNode currenFocus = FocusScope.of(context);
                                if(_formkey.currentState!.validate()){
                                  bool callResult = await login();
                                  if(!currenFocus.hasPrimaryFocus){
                                    //se o teclado estiver aberto ele fecha ele;
                                    currenFocus.unfocus();
                                  }
                                  if(callResult){
                                    Navigator.pushReplacementNamed(context, '/AppHome');
                                    // Navigator.of(context).pushReplacementNamed('/AppHome');
                                  } else{
                                    _passwordController.clear();
                                    //coloca uma mensagem de erro
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                              },
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.white),
                                foregroundColor: MaterialStatePropertyAll(Colors.black),
                              ),
                          ),
                        ),
                  ],
                ),
              ),
              
              
            ],      
          ),
        ),
      )
    );
  }
}