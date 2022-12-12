import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:procure_aqui/components/dataPicker.dart';
import 'package:procure_aqui/components/smallPurpleButton.dart';
import '../components/inputText.dart';
import 'package:intl/intl.dart';
import '../components/smallDropDown.dart';
import 'package:procure_aqui/models/user.dart';

class UserEditProfile extends StatefulWidget {
   UserEditProfile({required this.user, super.key});

  User user;

  @override
  State<UserEditProfile> createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> { 

  String? _username;
  String?  _email;   
  String? _password1;
  String? _sexDropDownValue;
  String? _city;   
  String? _cityValue;
  String? _stateValue;
  String? _state; 
  DateTime? _dateTime;
  String? password2ConfirmValue;
  int restartPage = 0;

  // Future<void> _submitForm(user) async {
  //   //http method put
  //   var url = Uri.parse('http://18.208.163.221/users/${user.getId}');
  //   Response response = await http.put(url, body: {
  //     {
  //       "email" : user,
  //       "username" : "admin",
  //       "birth_date" : "2001-05-23",
  //       "password" : "admin",
  //       "city" : "2"
  //     }
  //   } );
  //
  // }



  void sexDropDownHandler(String? selectedValue){
    if(selectedValue is String){
      setState(() {
        _sexDropDownValue = selectedValue;
      });
    }
  }

  void cityDropDownHandler(String? selectedValue){
    if(selectedValue is String){
      setState(() {
        _city = selectedValue;
      });
    }
  }

  void stateDropDownHandler(String? selectedValue){
    if(selectedValue is String){
      setState(() {
        _state = selectedValue;
      });
    }
  }


  void createAndShowDataPicker(BuildContext context){
    showDatePicker(
      context: context, 

      initialDate: DateTime.now(), 
      firstDate: DateTime(1950), 
      lastDate: DateTime(2099)
    ).then((date) {
      setState(() {
        _dateTime = date;
      });
    });
  }



  Widget _buildNameField(){
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(33, 0, 0, 5),
          child: Text('Nome*: ')
        ),
        Container(
          height: 50,
          width: 350,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4)
              )
            ),
            validator: (String? value){
              if(value!.isEmpty){
                return 'Name is Required';
              }
              else if( value.length <  4 ){
                return 'O nome precisa conter pelo menos 3 carcteres';
              }
            },
            onSaved: (String? value){
              _username = value;
              // print(_username);
            },
          ),
        )

      ],
    );
  }

  Widget _buildEmailField(){
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(33, 0, 0, 5),
          child: Text('Email*: ')
        ),
        Container(
          height: 50,
          width: 350,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4)
              )
            ),
            validator: (String? value){
              if(value!.isEmpty){
                return 'Email is Required';
              }
            },
            onSaved: (String? value){
              _email = value;
              // print(_email);
            },
          ),
        )

      ],
    );
  }



  Widget _buildCityField(){
    return Column(
      children: [
        Container(
          width: 150,
          margin: EdgeInsets.only(top:20, left: 28, bottom: 5),
          child: Text('Cidade*')
        ),
        Container(
          width: 160,
          height: 50,
          margin: EdgeInsets.only(left: 30),
          child: DropdownButtonFormField(items: const [
            DropdownMenuItem(child: Text('Rialma'),value: "Rialma"),
            DropdownMenuItem(child: Text('Ceres'),value: "Ceres"),
            DropdownMenuItem(child: Text('Goiania'),value: "Goiania"),
          ],
          // value: _sexDropDownValue,
          // onChanged: sexDropDownHandler,
          validator: (value) => value == null ? 'Campo obrigatório' : null ,
          value: _cityValue,
          onChanged: (_cityValue){
            cityDropDownHandler(_cityValue);
          },
          iconSize: 30,
          isExpanded: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.only(bottom: 5, left: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey
                )
            )
          ),
          ),
        ),
      ],
    );
  }

Widget _buildStateField(){
    return Column(
      children: [
        Container(
          width: 150,
          margin: EdgeInsets.only(top: 20, left: 28, bottom: 5),
          child: Text('Estado*')
        ),
        Container(
          width: 160,
          height: 50,
          margin: EdgeInsets.only(left: 30),
          child: DropdownButtonFormField(items: const [
            DropdownMenuItem(child: Text('Goiás'),value: "Goiás"),
          ],
          // value: _sexDropDownValue,
          // onChanged: sexDropDownHandler,
          value: _stateValue,
          onChanged: (_stateValue){
            stateDropDownHandler(_stateValue);
          },
          validator: (value) => value == null ? 'Campo obrigatório' : null ,
          iconSize: 30,
          isExpanded: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.only(bottom: 5, left: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey
                )
            )
          ),
          ),
        ),
      ],
    );
  }


  Widget _buildButton(){
    return Container(
            width: 148,
            height: 50,
            margin: EdgeInsets.only(left: 30, top: 20),
            child: 
              ElevatedButton(
                child:  Text(
                  'Salvar',
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
                onPressed:  () async {
                  if(!_formKey.currentState!.validate()){
                  return;
                 }
                  _formKey.currentState!.save();
                  //User user = User(id: 1, username:  _username, email: _email, password: _password1, city: _city, birthDate: _dateTime, sex: _sexDropDownValue, state: _state);
                  var url = Uri.parse('http://18.208.163.221/users/${widget.user.getId}/');
                  print(url);
                  Response responseGet = await http.get(url);
                  print(responseGet.body);

                  Response response = await http.put(url, body: {
                      "email" : _email,
                      "username" : _username,
                      "birth_date" : DateFormat('y-MM-d').format(_dateTime as DateTime),
                      // "password" : widget.user.getPassword,
                      "city" : "1",
                      "sex" : _sexDropDownValue
                      // "city" : _city,
                      // "state" : _state
                  });
                  print(response.body);
                  final snackBar = SnackBar(content: Text("Dados  alterados com sucesso!", textAlign: TextAlign.center), backgroundColor: Colors.green,);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pushReplacementNamed(context, '/AppHome');
                  //resetar page?

                  },
                style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(98, 0, 238, 30.0)),
                        foregroundColor: MaterialStatePropertyAll(Colors.white),          
                      ),
              ),
          );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, 
      appBar: AppBar(
        title: Text('Alteração de perfil do usuário'),
        backgroundColor: Color(0xFF3700B3),

      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text('')
              ),
              // inputField(inputText: 'Nome do usuário*', func: setUsername, userData: _username),
              _buildNameField(),
              _buildEmailField(),
              Row(
                children: [
                  smallDropDown(_sexDropDownValue,sexDropDownHandler ),
                  dataPicker(_dateTime, createAndShowDataPicker)
                ],
              ),
              Row(
                children: [
                  _buildCityField(),
                  _buildStateField()
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 150),
                child: Row(
                  children: [
                    _buildButton(),
                    smallPurpleButton('Cancelar', func: () { Navigator.pop(context); },)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
