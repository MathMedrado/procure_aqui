import 'package:flutter/material.dart';

class RestorePasswordPage extends StatefulWidget {
  const RestorePasswordPage({super.key});

  @override
  State<RestorePasswordPage> createState() => _RestorePasswordState();
}

class _RestorePasswordState extends State<RestorePasswordPage> {
  final _formkey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _tokenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Alteração de senha'),
        backgroundColor: Color(0xFF3700B3),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Color.fromRGBO(98, 0, 238, 30.0)
              ),
              margin: EdgeInsets.fromLTRB(50, 50, 50, 70),
              padding: EdgeInsets.all(20),
              width: 330,
              height: 171,
              child: Image.asset(
                'lib/assets/images/logo2.png',   
              ),
            ),
            Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Text('Nova Senha',)
                  ),
                  Container(
                      width: 357,
                      margin: EdgeInsets.fromLTRB(30, 15, 20, 50),
                      child:Column(
                        children: [
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4)
                              ),
                            ),
                            validator: (String? password){
                              if(password!.isEmpty){
                                return 'Você precisa informar a sua senha.';
                              }else if(password!.length < 10){
                                return 'A sua Senha precisa conter no minimo 10 caracteres';
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Text('Token de acesso',)
                  ),
                  Container(
                      width: 357,
                      margin: EdgeInsets.fromLTRB(30, 15, 20, 50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: Colors.white
                      ),
                      child:Column(
                        children: [
                          TextFormField(
                            controller: _tokenController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              )
                            ),
                            validator: (String? token){
                              if(token!.isEmpty){
                                return 'Informe o token que você recebeu no seu email.';
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(100, 60, 0, 10),
                      width: 220,
                      height: 50,
                      child: 
                        ElevatedButton(
                          child: Text(
                            'Redefinir Senha',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),
                          ),
                          onPressed: (){
                             if(!_formkey.currentState!.validate()){
                              return;
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(98, 0, 238, 30.0)),
                            foregroundColor: MaterialStatePropertyAll(Colors.white),
                            
              
                          ),
                      ),
                  ),
                ],
              ),
            ),
            
          ]
        ),
      ),
    );
  }
}