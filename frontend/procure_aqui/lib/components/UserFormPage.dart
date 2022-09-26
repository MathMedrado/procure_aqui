import 'dart:ui';

import 'package:flutter/material.dart';
import 'userForm.dart';
import 'package:intl/intl.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> { 

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
            inputField(inputText: 'Nome do usuário*'),
            inputField(inputText: 'Email*'),
            inputField(inputText: 'Senha*'),
            inputField(inputText: 'Confirme a sua senha*'),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 150,
                      margin: EdgeInsets.only(left: 28, bottom: 5),
                      child: Text('Sexo*')
                    ),
                    Container(
                      width: 160,
                      height: 50,
                      margin: EdgeInsets.only(left: 30),
                      child: DropdownButtonFormField(items: const [
                        DropdownMenuItem(child: Text('Masculino'),value: "Masculino"),
                        DropdownMenuItem(child: Text('Feminino'),value: "Feminino"),
                      ],
                      value: _sexDropDownValue,
                      onChanged: sexDropDownHandler,
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
                ),
                Column(
                  children: [
                    Container(
                      width: 150,
                      margin: EdgeInsets.only(left: 28, bottom: 5),
                      child: Text('data de nascimento*')
                    ),
                    Container(
                      width: 160,
                      height: 50,
                      margin: EdgeInsets.only(left: 30),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(4))
                      ),
                      child:  Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              _dateTime == null? '                     ' : DateFormat('d/MM/y').format(_dateTime!)
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.calendar_month),
                            iconSize: 25,
                            alignment: Alignment.bottomRight,
                            onPressed: (){
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
                            },
                          ),
                        ],
                      )
                    ),
                  ],
                ),
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
                    onChanged: (bool? value){
                      setState(() {
                        _isChecked2 = value;
                      });
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
                Container(
                  width: 148,
                  height: 40,
                  margin: EdgeInsets.only(left: 30, top: 20),
                  child: 
                    ElevatedButton(
                      child: const Text(
                        'Cadastrar',
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                      onPressed: (){},
                      style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(98, 0, 238, 30.0)),
                              foregroundColor: MaterialStatePropertyAll(Colors.white),          
                              ),
                    ),
                ),
                Container(
                  width: 148,
                  height: 40,
                  margin: EdgeInsets.only(left: 50, top: 20),
                  child: 
                    ElevatedButton(
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                      onPressed: (){

                      },
                      style: 
                      ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(98, 0, 238, 30.0)),
                        foregroundColor: MaterialStatePropertyAll(Colors.white),          
                      ),
                    ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
