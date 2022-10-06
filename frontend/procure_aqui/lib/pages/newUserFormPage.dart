import 'package:flutter/material.dart';

class newUserFormPage extends StatefulWidget {
  const newUserFormPage({super.key});

  @override
  State<newUserFormPage> createState() => _newUserFormPageState();
}

class _newUserFormPageState extends State<newUserFormPage> {

  String? _username;
  String?_email;
  String? _password1;
  String? _password2;
  String? _sexDropDownValue;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildNameField(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      validator: (String? value){
        if(value!.isEmpty){
          return 'Name is Required';
        }
      },
      onSaved: (String? value){
        _username = value;
        print(_username);
      },
    );
  }

    Widget _buildEmailField(){
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (String? value){
        if(value!.isEmpty){
          return 'email is Required';
        }
      },
      onSaved: (String? value){
        _email = value;
        print(_email);
      },
    );
  }

    Widget? _buildPassword1Field(){
    return null;
  }

  Widget? _buildPassword2Field(){
    return null;
  }

  Widget? _buildSexDropDownvalueField(){
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro'),),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildNameField(),
              _buildEmailField(),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: (){
                  if(!_formKey.currentState!.validate()){
                    return;
                  }
                  _formKey.currentState!.save();
                }, 
                child: Text('Submit')
              )
            ],
          )
        ),
      ),
    );
  }
}