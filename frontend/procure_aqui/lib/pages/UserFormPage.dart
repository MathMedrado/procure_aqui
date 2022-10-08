import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:procure_aqui/components/dataPicker.dart';
import 'package:procure_aqui/components/smallPurpleButton.dart';
import '../components/inputText.dart';
import 'package:intl/intl.dart';
import '../components/smallDropDown.dart';
import 'package:procure_aqui/models/user.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> { 

  String? _username;
  String?  _email;   
  String? _password1;   
  String? _password2;   
  String? _sexDropDownValue;
  String? _city;   
  String? _cityValue;
  String? _stateValue;
  String? _state; 
  DateTime? _dateTime;
  bool? _isChecked1 = false;
  bool? _isChecked2 = false;
  String? password2ConfirmValue;



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
      firstDate: DateTime(2001), 
      lastDate: DateTime(2099)
    ).then((date) {
      setState(() {
        _dateTime = date;
      });
    });
  }

  void setCheckBox1(bool? value){
      setState(() {
      _isChecked1 = value;
      // print(_isChecked1);
    });
  }

  void setCheckBox2(bool? value){
      setState(() {
      _isChecked2 = value;
      // print(_isChecked2);
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

    Widget _buildPassword1Field(){
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(33, 0, 0, 5),
          child: Text('Senha*: ')
        ),
        Container(
          height: 50,
          width: 350,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4)
              )
            ),
            validator: (String? value){
              password2ConfirmValue = value;
              if(value!.isEmpty){
                return 'Password is Required';
              }else if(value.length < 10){
                return 'A sua Senha precisa conter no minimo 10 caracteres';
              }
            },
            onSaved: (String? value){
              _password1 = value;
              // print(_password1);
            },
          ),
        )

      ],
    );
  }

  Widget _buildPassword2Field(){
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(33, 0, 0, 5),
          child: Text('Confirme a sua senha*: ')
        ),
        Container(
          height: 50,
          width: 350,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4)
              )
            ),
            validator: (String? value){
              if(value!.isEmpty){
                return 'É necessário informar a sua senha novamente';
              }else if (value.length <10 ){
                return 'A sua Senha precisa conter no minimo 10 caracteres';
              }else if (value != password2ConfirmValue){
                return 'As duas senhas precisam ser iguais!';
              }
            },
            onSaved: (String? value){
              _password2 = value;
              // print(_password2);
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
            DropdownMenuItem(child: Text('São Paulo'),value: "São Paulo"),
            DropdownMenuItem(child: Text('Rio De Janeiro'),value: "Rio de Janeiro"),
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
            height: 40,
            margin: EdgeInsets.only(left: 30, top: 20),
            child: 
              ElevatedButton(
                child:  Text(
                  'Cadastrar',
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
                onPressed: _isChecked1 == true && _isChecked2 ==true? (){
                  if(!_formKey.currentState!.validate()){
                  return;
                }
                  _formKey.currentState!.save();
                  // print(_username );
                  // print(_email );
                  // print(_password1 );
                  // print(_password2 );
                  print(_dateTime );
                  print(_sexDropDownValue );
                  print(_city);
                  print(_state);
                  User user1 = User(id: 1, username:  _username, email: _email, password: _password1, city: _city, birthDate: _dateTime, sex: _sexDropDownValue, state: _state);
                  Navigator.of(context).pushNamed('/UserProfilePage', arguments: user1);
                } : null,
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
        title: Text('Cadastro de usuário'),
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
              _buildPassword1Field(),
              _buildPassword2Field(),
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
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Checkbox(
                      value: _isChecked1, 
                      onChanged: (_isChecked1){
                        setCheckBox1(_isChecked1);
                      },
                    ),
                  ),
                  Text(
                    'Li e concordo com os termos de uso',
                    style: TextStyle(
                      fontSize: 12
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Checkbox(
                      value: _isChecked2, 
                      onChanged: (_isChecked2){
                        setCheckBox2(_isChecked2);
                      }
                    ),
                  ),
                  const SizedBox(
                    width: 320,
                    child: Text(
                      'Eu autorizo o uso de meus dados e aceito os termos e condições de uso',
                      style: TextStyle(
                        fontSize: 12
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  _buildButton(),
                  smallPurpleButton('Cancelar')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
