import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:procure_aqui/components/smallPurpleButton.dart';
import 'package:shared_preferences/shared_preferences.dart';



class productRegistrationPage extends StatefulWidget {
   productRegistrationPage({required this.barCode, super.key});

   String barCode;

  @override
  State<productRegistrationPage> createState() => _productRegistrationPageState();
}

class _productRegistrationPageState extends State<productRegistrationPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _productName;
  double? _productPrice;
  String? _category;

  @override
  void initState(){
    super.initState();
    // bool check = false;
    // isProductRegistred(widget.barCode).then((bool value) {
    //   print('antes $value');
    //   isProductCreated = value;
    //   print('depois $isProductCreated');
    // } );
    setState(() {
          isProductCreated = isProductRegistred(widget.barCode);

    });
    setState(() {
          productName = getProductNameIfExist(widget.barCode);

    });

    // print('O produto foi criado? $check');
    // isProductCreated = isProductRegistred(widget.barCode) as bool;
    // print(isProductCreated);
    // if(check == true){
    //   getProductNameIfExist(widget.barCode).then((String value) => productName = value);
    //   print(productName);
    // }
    // else{
    //   productName = 'Produto não encontrado';
    //   print(productName);
    // }

  }

  // _initData() async{

  // }
  

  late Future<bool> isProductCreated; 
  late Future<String> productName;

  Future <bool> isProductRegistred(String barCode) async {
    var url = Uri.parse('http://10.0.2.2:8000/products/?bar_code=${barCode}');
    var response = await http.get(url);
    var values = jsonDecode(response.body);
    print('tem produtos? $values');
    if(values != []){
      return false;
    }
    else{
      return true;
    }

  }

  Future <String> getProductNameIfExist(String barCode) async {
    var url = Uri.parse('http://10.0.2.2:8000/products/?bar_code=${barCode}');
    var response = await http.get(url);
    var values = jsonDecode(response.body);
    print(values);
    if(values == []){
      String productName = values[0]['product_name'];
      print('nome do produto $productName');
    }else {
      String productName = '';  
    }

    return productName;

  }

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
          child: Text('Categoria: *')
        ),
        Container(
          margin: EdgeInsets.only(left: 28),
          width: 350,
          height: 50,
          child: DropdownButtonFormField(items: const [
            DropdownMenuItem(child: Text('Hortifruti'),value: "1"),
            DropdownMenuItem(child: Text('Limpeza'),value: "2"),
            DropdownMenuItem(child: Text('Açougue'),value: "3"),
            DropdownMenuItem(child: Text('Bebidas'),value: "4"),
            DropdownMenuItem(child: Text('Produtos Gerais'),value: "5"),
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

  Widget _newProduct(){
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
                  smallPurpleButton('Cadastrar',  func: () async {
                      if(!_formKey.currentState!.validate()){
                        return;              
                      }
                      _formKey.currentState!.save();
                      print(_productName);
                      print(_productPrice);
                      print(_category);
                      SharedPreferences sharedPreferences =  await SharedPreferences.getInstance();
                      String? supermarket = await sharedPreferences.getString('supermarket');


                      var url = Uri.parse('http://10.0.2.2:8000/products/');
                      var response = await http.post(url, body: {
                        "product_name" : _productName,
                        "bar_code" : widget.barCode,
                        "price" : _productPrice?.toString(),
                        "category": _category,
                        "supermarket" : supermarket
                      });
                      print(response.body);
                      print(response.statusCode);
                      Navigator.of(context).pushReplacementNamed('/AppHome');

                  },
                  ),
                  smallPurpleButton('Cancelar', func: () {
                    Navigator.of(context).pushReplacementNamed('/AppHome');
                  },),
                ],
              )
            ],
          
          ),
        )
      ),
    );
  }


  Widget _productAlredyExist(productName){
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
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Text(
                    productName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              _buildProductPriceField(),
              _buildCategoryDropdown(),
              Container(margin: EdgeInsets.only(bottom: 250),),
              Row(
                children: [
                  smallPurpleButton('Cadastrar',  func: () async {
                      if(!_formKey.currentState!.validate()){
                        return;              
                      }
                      _formKey.currentState!.save();
                      print(_productName);
                      print(_productPrice);
                      print(_category);
                      SharedPreferences sharedPreferences =  await SharedPreferences.getInstance();
                      String? supermarket = await sharedPreferences.getString('supermarket');


                      var url = Uri.parse('http://10.0.2.2:8000/products/');
                      var response = await http.post(url, body: {
                        "product_name" : productName,
                        "bar_code" : widget.barCode,
                        "price" : _productPrice?.toString(),
                        "category": _category,
                        "supermarket" : supermarket
                      });
                      print(response.body);
                      print(response.statusCode);
                      Navigator.of(context).pushReplacementNamed('/AppHome');

                  },
                  ),
                  smallPurpleButton('Cancelar', func: () {
                    Navigator.of(context).pushReplacementNamed('/AppHome');
                  },),
                ],
              )
            ],
          
          ),
        )
      ),
    );
  }


  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([isProductCreated, productName]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
      if (snapshot.hasData) {
        if(snapshot.data![0] == false){
          return GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            }, 
            child: _newProduct()
            );
        } else {
            return GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            }, 
            child: _productAlredyExist(snapshot.data![1])
            );
        }
      }
      else {
        final error = snapshot.error;
        print('Ocorreu umerror');
        return CircularProgressIndicator();
      }
    }
    );


  }
}