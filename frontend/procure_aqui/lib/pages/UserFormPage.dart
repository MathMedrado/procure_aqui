import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:procure_aqui/components/dataPicker.dart';
import 'package:procure_aqui/components/smallPurpleButton.dart';
import '../components/inputText.dart';
import 'package:intl/intl.dart';
import '../components/smallDropDown.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> { 

  final _username =  TextEditingController();
  final  _email =  TextEditingController();
  final _password1 =  TextEditingController();
  final _password2 =  TextEditingController();
  String? _sexDropDownValue;
  DateTime? _dateTime;
  bool? _isChecked1 = false;
  bool? _isChecked2 = false;



  void sexDropDownHandler(String? selectedValue){
    if(selectedValue is String){
      setState(() {
        _sexDropDownValue = selectedValue;
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
    });
  }

  void setCheckBox2(bool? value){
      setState(() {
      _isChecked2 = value;
      print(_isChecked2);
    });
  }

  // void setUsername(TextEditingController? name){
  //   setState(() {
  //     _username = name;
  //   });
  // }
  //   void setEmail(TextEditingController? email){
  //   setState(() {
  //     _email = email;
  //   });
  // }

  //   void setPassword1(TextEditingController? password1){
  //   setState(() {
  //     _password1 = password1;
  //   });
  // }
  //   void setPassword2(TextEditingController? password2){
  //   setState(() {
  //     _password2 = password2;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, 
      appBar: AppBar(
        title: Text('Cadastro de usuário'),
        backgroundColor: Color(0xFF3700B3),

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text('')
            ),
            // inputField(inputText: 'Nome do usuário*', func: setUsername, userData: _username),
            inputField(inputText: 'Nome*'),
            inputField(inputText: 'Email*'),
            inputField(inputText: 'Senha*'),
            inputField(inputText: 'Confirme a sua senha*'),
            Row(
              children: [
                smallDropDown(_sexDropDownValue,sexDropDownHandler ),
                dataPicker(_dateTime, createAndShowDataPicker)
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Checkbox(
                    value: _isChecked1, 
                    onChanged: (bool? value){
                      setState(() {
                        _isChecked1 = value;
                      });
                    }
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
                smallPurpleButton('Cadastrar'),
                smallPurpleButton('Cancelar')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
