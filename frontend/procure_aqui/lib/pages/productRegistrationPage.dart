
import 'package:flutter/material.dart';
import 'package:procure_aqui/components/smallPurpleButton.dart';


class productRegistrationPage extends StatefulWidget {
  const productRegistrationPage({super.key});

  @override
  State<productRegistrationPage> createState() => _productRegistrationPageState();
}

class _productRegistrationPageState extends State<productRegistrationPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _productName;
  double? _productPrice;
  String? _category;

    Widget _buildProductNameField(){
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(33, 0, 0, 5),
          child: Text('Nome do produto*: ')
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
              _productName = value;
              // print(_username);
            },
          ),
        )

      ],
    );
  }

  Widget _buildProductPriceField(){
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(33, 0, 0, 5),
          child: Text('Preço do produto*: ')
        ),
        Container(
          height: 50,
          width: 350,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4)
              )
            ),
            // validator: (Double? value){
            //   return;
            // },
            onSaved: (String? value){
              _productPrice = double.tryParse(value!);
              // print(_username);
            },
          ),
        )

      ],
    );
  }

  Widget _buildCategoryDropdown(){
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 28),
          width: 350,
          child: Text('Sexo*')
        ),
        Container(
          margin: EdgeInsets.only(left: 28),
          width: 350,
          height: 50,
          child: DropdownButtonFormField(items: const [
            DropdownMenuItem(child: Text('Hortifruti'),value: "hortifruti"),
            DropdownMenuItem(child: Text('Limpeza'),value: "limpeza"),
            DropdownMenuItem(child: Text('Açougue'),value: "acougue"),
            DropdownMenuItem(child: Text('Bebidas'),value: "bebidas"),
            DropdownMenuItem(child: Text('Produtos Gerais'),value: "produtos gerais"),
          ],
          // value: _sexDropDownValue,
          // onChanged: sexDropDownHandler,
          validator: (value) => value == null ? 'Campo obrigatório' : null ,
          value: _category,
          onChanged: (String? value){
              _category = value;
              print(_category);
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


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xFF3700B3),
        title: Text('Cadastro de produtos'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container( margin:  EdgeInsets.only(bottom: 50),),
              _buildProductNameField(),
              _buildProductPriceField(),
              _buildCategoryDropdown(),
              Container(margin: EdgeInsets.only(bottom: 250),),
              Row(
                children: [
                  smallPurpleButton('Cadastrar',  func: () { 
                      if(!_formKey.currentState!.validate()){
                        return;              
                      }
                      _formKey.currentState!.save();
                      print(_productName);
                      print(_productPrice);
                      print(_category);
                    },
                  ),
                  smallPurpleButton('Cancelar', func: () {  },),
                ],
              )
            ],
          
          ),
        )
      ),
    );
  }
}