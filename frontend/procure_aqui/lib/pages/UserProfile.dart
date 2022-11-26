import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:procure_aqui/components/userPhoto.dart';
import 'package:procure_aqui/components/userInformation.dart';
import 'package:procure_aqui/components/userInformationInRow.dart';
import 'package:procure_aqui/components/userInputButton.dart';
import 'package:procure_aqui/models/user.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



class UserProfilePage extends StatefulWidget {
  const UserProfilePage  ( { required this.user , super.key});

  final User user;

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  @override
  void initState(){
    super.initState();
    userData = fetchUserInfo();
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

  // final String? username = user.getEmail;
  final String emailInformation = 'Email: ';
  final String dateInformation = 'Data de nascimento: ';
  final String sexInformation = 'Sexo: ';
  final String cityInformation = 'Cidade: ';
  final String stateInformation = 'Estado: ';



//   @override
  Future<bool> logout() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }
  late Future<User> userData;

  Future<User> fetchUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userEmail = sharedPreferences.getString('email');
    print(userEmail);
    var userUrl = Uri.parse('http://10.0.2.2:8000/users/?search=$userEmail');
    Response responseUser = await http.get(userUrl);
    print(responseUser.body);
    print(jsonDecode(responseUser.body)[0]['id']);
    print(jsonDecode(responseUser.body)[0]['birth_date']);
    print(responseUser.statusCode);

    // String userData = jsonDecode(responseUser.body)['username'];
    // print(userData);

    if(responseUser.statusCode == 200){
      return User(id: jsonDecode(responseUser.body)[0]['id'], birthDate: DateTime.parse(jsonDecode(responseUser.body)[0]['birth_date']) , city: jsonDecode(responseUser.body)[0]['city']['city_name'], email: jsonDecode(responseUser.body)[0]['email'], password: jsonDecode(responseUser.body)[0]['password'], sex: jsonDecode(responseUser.body)[0]['sex'], state: jsonDecode(responseUser.body)[0]['city']['state'], username: jsonDecode(responseUser.body)[0]['username'] );
    }
    else{
      return User(id: jsonDecode(responseUser.body)[0]['id'], birthDate: DateTime.parse(jsonDecode(responseUser.body)[0]['birth_date']) , city: jsonDecode(responseUser.body)[0]['city']['city_name'], email: jsonDecode(responseUser.body)[0]['email'], password: jsonDecode(responseUser.body)[0]['password'], sex: jsonDecode(responseUser.body)[0]['sex'], state: jsonDecode(responseUser.body)[0]['city']['state'], username: jsonDecode(responseUser.body)[0]['username'] );
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userData,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 270,
                    color: Color(0xFF3700B3),
                    child: Column(
                      children: [
                        userPhoto(snapshot.data!.getUsername)
                      ],
                    ),
                  ),
                  UserInformation(snapshot.data!.getEmail, emailInformation),
                  UserInformation(DateFormat('d/MM/y').format(snapshot.data!.getBirthDate as DateTime), dateInformation),
                  UserInformation(snapshot.data!.getSex, sexInformation),
                  Row(
                    children: [
                      userInformationInRow(cityInformation, snapshot.data!.getCity),
                      userInformationInRow(stateInformation, snapshot.data!.getState),
                    ],
                  ),
                  userInputButton(Color(0xFF7B61FF), 'Atualizar Dados', (){
                    Navigator.of(context).pushNamed('/UserEditProfile', arguments: snapshot.data!);
                  }),
                  userInputButton(Color(0xFFadd8e6), 'Sair da conta', () async {
                    bool leave = await logout();
                    if(leave){
                      Navigator.pushReplacementNamed(context, '/');
                    }

                  }),
                  userInputButton(Color(0xFFE70101), 'Exclusão da conta', (){
                    Navigator.of(context).pushNamed('/UserProfileExclusion', arguments:  snapshot.data!);
                  }),

                ],
              ),
            );
          }
          else{
            final error = snapshot.error;
            print(error);
            return  CircularProgressIndicator();
          }
        }
    );
  }
}