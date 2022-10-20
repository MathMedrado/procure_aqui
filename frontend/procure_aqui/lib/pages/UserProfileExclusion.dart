import 'package:flutter/material.dart';
import 'package:procure_aqui/models/user.dart';
import 'package:procure_aqui/components/userPhoto.dart';

class UserProfileExclusion extends StatefulWidget {
  const UserProfileExclusion( {required this.user, super.key});
  
  final User user;


  @override
  State<UserProfileExclusion> createState() => _UserProfileExclusionState();
}

class _UserProfileExclusionState extends State<UserProfileExclusion> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? email;
  String? password;

  _submitExclusion(){
    email = emailController.text;
    password = passwordController.text;
    print(email);
    print(password);
  }

  Widget _buildPopUpCard(){
    return Center(
      child: Card(
        child:  Container(
          padding: EdgeInsets.all(20),
          width: 375,
          height: 200,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xFF3700B3),
          ),
          child: Column(
            children: [
              Container(
                width: 260,
                child: Text(
                  'Você tem Certeza que deseja exluir a sua conta?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30, top: 35),
                    width: 103,
                    height: 27,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ), 
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red)
                      ),
                      child: Text(
                        'Sim',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                        ),
                      ),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),                
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 60, top: 35),
                    width: 103,
                    height: 27,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.blue
                    ),  

                    child: ElevatedButton(
                      child: Text(
                        'Não',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                        ),
                      ),
                      onPressed: (){
                        Navigator.of(context).pop();
                      }
                    ), 

                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context){
    return showDialog(
      context: context, 
      builder: (BuildContext context){
        return _buildPopUpCard();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3700B3),
        title: Text('Exclusão da conta'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: double.infinity,
                height: 270,
                color: Color(0xFF3700B3),
                child: Column(
                  children: [
                    userPhoto('Matheus Medrado')
                  ],
                ),
              ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 40),
              child: Text(
                'Email*:',
                style: TextStyle(
                  fontSize: 15
                ),
              )
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 5),
              padding: EdgeInsets.only(left: 5),
              width: 357,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Colors.grey)
              ),
              child: TextField(
                controller: emailController,
                 decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              )
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'Senha*:',
                style: TextStyle(
                  fontSize: 15
                ),
                
                )
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 5),
              width: 357,
              height: 45,
              padding: EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Colors.grey)
              ),
               child: TextField(
                 controller: passwordController,
                 obscureText: true,
                 style: TextStyle(
                  fontSize: 18
                 ),
                  decoration: InputDecoration(
                   border: InputBorder.none,
                 ),
               )
            ),
            Container(
              width: 220,
              height: 45,
              margin: EdgeInsets.only(left: 95, top: 40),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Color(0xFF7B61FF)),
                  ),
                 child: Text(
                  'Exclusão dos dados',
                  style: TextStyle(
                    fontSize: 18
                  ),
                  ),
                onPressed: () => _dialogBuilder(context)
              ),
            ),
          ],
        ),
      ),
    );
  }
}