import 'package:flutter/material.dart';
import 'package:procure_aqui/components/userPhoto.dart';
import 'package:procure_aqui/components/userInformation.dart';
import 'package:procure_aqui/components/userInformationInRow.dart';
import 'package:procure_aqui/components/userInputButton.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage ( {super.key});

  final String username = 'Ariana Grande da Silva';
  final String emailInformation = 'Email: ';
  final String email = 'Arianagrande@gmail.com';
  final String dateInformation = 'Data de nascimento: ';
  final String date = '23/06/2001';
  final String sexInformation = 'Sexo: ';
  final String sex = 'feminino';
  final String cityInformation = 'Cidade: ';
  final String city = 'Faina';
  final String stateInformation = 'Estado: ';
  final String state = 'Goiás';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil do usuário"),
        backgroundColor: Color(0xFF3700B3),
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
                  userPhoto(username)   
                ],
              ),
            ),
            UserInformation(email, emailInformation),
            UserInformation(date, dateInformation),
            UserInformation(sex, sexInformation),
            Row(
              children: [
                userInformationInRow(cityInformation, city),
                userInformationInRow(stateInformation, state),
              ],
            ),
            userInputButton(Color(0xFF7B61FF), 'Atualizar Dados'),
            userInputButton(Color(0xFF7B61FF), 'Atualizar Dados'),
            userInputButton(Color(0xFFE70101), 'Atualizar Dados'),
            
          ],
        ),
      ),
    bottomNavigationBar: BottomNavigationBar(
      items:const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
      ],
      backgroundColor: Color(0xFF3700B3),
    ),
    );
  }
}