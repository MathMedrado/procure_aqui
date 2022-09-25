import 'package:flutter/material.dart';
import 'userForm.dart';

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> { 

  String? _sexDropDownValue;

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
      appBar: AppBar(
        title: Text('Cadastro de usuário'),
        backgroundColor: Color(0xFF3700B3),

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 40, 0, 50),
            child: Text(
              'Cadastro de usuário',
              style: TextStyle(
                fontSize: 20
              ),
              ),
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
            ],
          )
        ],
      ),
    );
  }
}
