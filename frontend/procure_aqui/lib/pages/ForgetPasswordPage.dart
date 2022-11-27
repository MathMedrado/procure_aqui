import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPasswordPage> {
  final forgetEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Recuperação de senha'),
        backgroundColor: Color(0xFF3700B3),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Container(
              margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Text('Email',)
            ),
            Container(
              height: 61,
              width: 357,
              margin: EdgeInsets.fromLTRB(30, 15, 0, 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Colors.white
              ),
              child:Column(
                children: [
                  TextField(
                    controller: forgetEmailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      )
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(30, 0, 50, 0),
              child: Text(
                'Será enviado para o seu email um passo a passo de como recuperar a sua senha.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 18,
                  ),
                ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(100, 80, 0, 10),
              width: 220,
              height: 50,
              child: 
                ElevatedButton(
                  child: Text(
                    'Recuperar Senha',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                  onPressed: () async {
                    var url = Uri.parse('http://18.208.163.221/api/password_reset/');
                    print(url);
                    var response = await http.post(url, body: {
                      "email" : forgetEmailController.text
                    });
                    print(response.body);
                    Navigator.of(context).pushNamed('/RestorePassword');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(98, 0, 238, 30.0)),
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                    
      
                  ),
              ),
           ),
          ]
        ),
      ),
    );
  }
}