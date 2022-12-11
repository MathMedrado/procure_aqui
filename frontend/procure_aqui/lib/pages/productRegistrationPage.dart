import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:procure_aqui/components/listOfProductCard.dart';
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
  late bool isProductCreated;
  late String productName;
  late double ProductActualPrice;
  bool _isLoading = true;
  late String img;
  late bool newSupermarket;
  late String productId;
  late List<String> supermarketNameList;
  late String supermarketSettedName;
 
  @override
  void initState(){
    super.initState();
    _initValues();
    _delay();

  }

  // @override
  // void initState(){
  //   super.initState();
  //   // bool check = false;

  //   setState(() {
  //         //isProductCreated = isProductRegistred(widget.barCode);
  //     isProductRegistred(widget.barCode).then((bool value) {
  //       print('antes $value');
  //       isProductCreated = value;
  //       print('depois $isProductCreated');
  //     } );
  //     print('olha aqui $isProductCreated');

  //   });
  //   setState(() {
  //         //productName = getProductNameIfExist(widget.barCode);
  //     print('O produto foi criado? $isProductCreated');
  //     if(isProductCreated == true){
  //       getProductNameIfExist(widget.barCode).then((String value) => productName = value);
  //       print(productName);
  //     }
  //     else{
  //       productName = 'Produto não encontrado';
  //       print(productName);
  //     }
  //   });

  //   // print('O produto foi criado? $check');
  //   // isProductCreated = isProductRegistred(widget.barCode) as bool;
  //   // print(isProductCreated);
  //   // if(check == true){
  //   //   getProductNameIfExist(widget.barCode).then((String value) => productName = value);
  //   //   print(productName);
  //   // }
  //   // else{
  //   //   productName = 'Produto não encontrado';
  //   //   print(productName);
  //   // }

  // }

  // _initData() async{

  // }
  

  // late bool isProductCreated; 
  // late String productName;

  Future <bool> isProductRegistred(String barCode) async {
    var url = Uri.parse('http://18.208.163.221/products/?bar_code=${barCode}');
    var response = await http.get(url);
    var values = jsonDecode(response.body);
    print('tem produtos? $values');
    print(values.length);
    if(values.length == 0){
      return false;
    }
    else{
      return true;
    }

  }

  Future <String> getProductNameIfExist(String barCode) async {
    var url = Uri.parse('http://18.208.163.221/products/?bar_code=${barCode}');
    var response = await http.get(url);
    var values = jsonDecode(response.body);
    String productName = 'Produto Não Encontrado';
    print(values);
    if(values != []){
      productName = values[0]['product_name'];
      print('nome do produto $productName');
      return productName;
    }else {
      return productName = 'Produto não encontrado';  
    }
  }

  Future <double> getProductPriceIfExist(String barCode) async {
    var url = Uri.parse('http://18.208.163.221/products/?bar_code=${barCode}');
    var response = await http.get(url);
    var values = jsonDecode(response.body);
    String productName = 'Produto Não Encontrado';
    print(values);
    if(values != []){
      ProductActualPrice = values[0]['price'];
      print('Preço do produto $ProductActualPrice');
      return ProductActualPrice;
    }else {
      return ProductActualPrice = 0 as double;  
    }
  }


  Future <String> getProductImgIfExist(String barCode) async {
    var url = Uri.parse('http://18.208.163.221/products/?bar_code=${barCode}');
    var response = await http.get(url);
    var values = jsonDecode(response.body);
    String img =  "http://18.208.163.221/media/fotos/default/%C3%ADndice.png";
    print(values);
    if(values != []){
      img = values[0]['image_url'];
      print('url da imagem: $img');
      return img;
    }else {
      return img = "http://18.208.163.221/media/fotos/default/%C3%ADndice.png";  
    }
  }

    Future <bool> getSupermarketIfExist(String barCode) async {
    var url = Uri.parse('http://18.208.163.221/products/?bar_code=${barCode}');
    var response = await http.get(url);
    var values = jsonDecode(response.body);
    print(values);
    String supermarketName = values[0]['supermarket']['id'].toString();
    print('erro aqui $supermarketName');
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? getSupermarketName = sharedPreference.getString('supermarket');
    print('produto $supermarketName, salvo $getSupermarketName');
    if(values != []){
      if(supermarketName == getSupermarketName){
        newSupermarket = true;
        return newSupermarket;
      }else{
        newSupermarket = false;
        return newSupermarket;
      }
    }else {
      newSupermarket = false;
      return newSupermarket;  
    }
  }

  Future <String?> getSupermarkedSettedIfExist(String barCode) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String? getSupermarketName = sharedPreference.getString('supermarket');
    var url = Uri.parse('http://18.208.163.221/supermarkets/$getSupermarketName');
    var response = await http.get(url);
    var values = jsonDecode(response.body);
    print(values);
    String supermakerName = values['supermarket_name'];
    return supermakerName;
  }


  Future <String> getProductIdIfExist(String barCode) async {
    var url = Uri.parse('http://18.208.163.221/products/?bar_code=${barCode}');
    var response = await http.get(url);
    var values = jsonDecode(response.body);
    print(values);
    if(values != []){
      productId = values[0]['id'].toString();
      print('O id do produto  é $productId');
      return productId;
    }else {
      return productId;  
    }
  }

  Future <List<String>> getListOfSupermarketIfExist(String barCode) async {
    var url = Uri.parse('http://18.208.163.221/products/?bar_code=${barCode}');
    var response = await http.get(url);
    var values = jsonDecode(response.body);
    supermarketNameList = [];
    print(values);
    if(values != []){
      for(int x = 0; x < values.length; x++ ){
        String supermakerName = values[x]['supermarket']['supermarket_name'];
        supermarketNameList.add(supermakerName);
      }
      print(supermarketNameList);
      return supermarketNameList;
    }else {
      supermarketNameList = [];
      return supermarketNameList;  
    }
  }

    Widget _buildProductNameField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(15, 0, 0, 5),
          child: Text('Nome do produto*: ')
        ),
        Container(
          height: 50,
          width: 350,
          margin: EdgeInsets.fromLTRB(15, 0, 0, 20),
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

  Widget _buildProductPriceField(String textPassed){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(15, 0, 0, 5),
          child: Text(textPassed)
        ),
        Container(
          height: 50,
          width: 350,
          margin: EdgeInsets.fromLTRB(15, 0, 0, 20),
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4)
              )
            ),
            // validator: (double? value){
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
          margin: EdgeInsets.fromLTRB(15, 0, 0, 5),
          width: 350,
          child: Text('Categoria: *')
        ),
        Container(
          margin: EdgeInsets.fromLTRB(15, 0, 0, 20),
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
              _buildProductPriceField('Preço do produto: '),
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


                      var url = Uri.parse('http://18.208.163.221/products/');
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


  Widget _productAlredyExist(String title, String textForm, bool showPrice){
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xFF3700B3),
        title: Text(title),
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
              Center(
                child: Container(
                  margin: EdgeInsets.only(left: 10, bottom: 25),
                  width: 200,
                  height: 200,
                  child: Image.network(
                    img,
                    //'lib/assets/images/bolo.jpeg'
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: showPrice? Text(
                    'Preço atual: R\$ ${ProductActualPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ) : Container(),
                ),
              ),
              _buildProductPriceField(textForm),
              Container(margin: EdgeInsets.only(bottom: 180),),
              Row(
                children: [
                  smallPurpleButton('Salvar',  func: () async {
                      if(!_formKey.currentState!.validate()){
                        return;              
                      }
                      _formKey.currentState!.save();
                      //print(_productName);
                      print(_productPrice);
                      SharedPreferences sharedPreferences =  await SharedPreferences.getInstance();
                      String? supermarket = await sharedPreferences.getString('supermarket');
                      var getUrl = Uri.parse('http://18.208.163.221/products/?product_name=$productName');
                      print(getUrl);
                      var getResponse = await http.get(getUrl);
                      var getValues = jsonDecode(getResponse.body);
                      print(getValues);
                      String categoryId = getValues[0]['category'];
                      print(categoryId);
                      int categoryIdValue = 1;
                      //print('Parou aqui');
                      switch (categoryId){
                        case 'Bebidas':
                          categoryIdValue = 4;
                          break;
                        case 'AÃ§ougue':
                          categoryIdValue = 3;
                          break;
                        case 'Hortifruti':
                          categoryIdValue = 1;
                          break;
                        case 'Produtos Gerais':
                          categoryIdValue = 5;
                          break;
                        case 'Limpeza':
                          categoryIdValue = 2;
                          break;
                      }
                      //print('Parou aqui');
                      print(categoryIdValue.toString());

                      if(newSupermarket == false){
                          var url = Uri.parse('http://18.208.163.221/products/');
                          var response = await http.post(url, body: {
                          "product_name" : productName,
                          "bar_code" : widget.barCode,
                          "price" : _productPrice?.toString(),
                          "category": categoryIdValue.toString(),
                          "supermarket" : supermarket
                        });
                        print(response.body);
                        print(response.statusCode);
                      }else{
                        var url = Uri.parse('http://18.208.163.221/products/$productId/');
                        print(url);
                        var response = await http.put(url, body: {
                          "product_name" : productName,
                          "bar_code" : widget.barCode,
                          "price" : _productPrice?.toString(),
                          "category": categoryIdValue.toString(),
                          "supermarket" : supermarket
                        });
                        print(response.statusCode);
                        if(response.statusCode == 202){
                            var values = jsonDecode(response.body);
                            print(values);
                            String utf8convert(String text) {
                              List<int> bytes = text.toString().codeUnits;
                              return utf8.decode(bytes);
                            }
                            String errorMessage = values["Error"];
                            errorMessage = utf8convert(errorMessage);
                            print(errorMessage);
                            final snackBar = SnackBar(content: Text(errorMessage, textAlign: TextAlign.center), backgroundColor: Colors.red,);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                      Navigator.of(context).pushReplacementNamed('/AppHome');
                  },
                  ),
                  smallPurpleButton('Cancelar', func: () {
                    Navigator.of(context).pushReplacementNamed('/AppHome');
                  },),
                ],
              ),
            ],
          
          ),
        )
      ),
    );
  }

_initValues() {
    isProductRegistred(widget.barCode).then((value) {
      setState(() {
        isProductCreated = value;
        print(isProductCreated);
      });
    },);
    productName = 'aqui';
    getProductNameIfExist(widget.barCode).then((value) {
      setState(() {
        productName = value;
        print(productName);
      });
    });
    getProductImgIfExist(widget.barCode).then((value) {
      setState(() {
        img = value;
        print(value);
      });
    });
    getProductPriceIfExist(widget.barCode).then((value) => {
      setState(() {
        ProductActualPrice = value;
        print(value);
      })
    });
    getSupermarketIfExist(widget.barCode).then((value) => {
      setState(() {
        newSupermarket = value;
        print(newSupermarket);
      })
    });
    getProductIdIfExist(widget.barCode).then((value) => {
      setState(() {
        productId = value;
        print("Possivel erro aqui $productId");
      })
    });
    getListOfSupermarketIfExist(widget.barCode).then((value) => {
      setState(() {
        supermarketNameList = value;
        print("Lista de supermercados: ttgg $supermarketNameList");
      })
    });
    getSupermarkedSettedIfExist(widget.barCode).then((value)  {
      print(value);
      setState(() {
        supermarketSettedName = value!;
        print("O nome do supermercado setado no shared: $supermarketSettedName");
      });
    });
    
}

_delay(){
    Future.delayed(Duration(seconds: 2), () { // <-- Delay here
    setState(() {
        _isLoading = false; // <-- Code run after delay
      });
    });
}
  
  @override
  Widget build(BuildContext context) {
      if(_isLoading){
        return  const CircularProgressIndicator();
      } else{
        if( isProductCreated == false){
          return GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            }, 
            child: _newProduct()
            );
        } else {
            if(newSupermarket == true){
              if(supermarketNameList.contains(supermarketSettedName)){
              return GestureDetector(
              onTap: (){
                FocusScope.of(context).unfocus();
              }, 
                child: _productAlredyExist('Alteração de preço', 'Novo preço: ', true)
              );
              }else{
              return GestureDetector(
                onTap: (){
                  FocusScope.of(context).unfocus();
                }, 
                  child: _productAlredyExist('Cadastro de produto', 'Preço do produto: ', false)
                );
              }

            }else{
              return GestureDetector(
                onTap: (){
                  FocusScope.of(context).unfocus();
                }, 
                  child: _productAlredyExist('Cadastro de produto', 'Preço do produto: ', false)
                );
            }

        }
      }
      }
}