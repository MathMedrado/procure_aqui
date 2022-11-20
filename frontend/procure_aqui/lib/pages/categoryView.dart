import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:procure_aqui/components/sideBarMenu.dart';
import 'package:procure_aqui/components/smallPurpleButton.dart';
import 'package:procure_aqui/models/supermarket.dart';
import 'package:procure_aqui/models/product.dart';
import 'package:procure_aqui/components/productViewInRow.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:procure_aqui/token.dart';

import '../components/appBarSearchFeature.dart';

class CategoryView extends StatefulWidget {
   CategoryView({required this.categoryId, super.key});

  int categoryId;
  @override
  State<CategoryView> createState() => _CategoryViewState();
}



class _CategoryViewState extends State<CategoryView> {

  String? supermarketValue;

  @override
  void initState(){
    super.initState();
    productData = fetchProductInfo();
  }
  late Future<List<Product>> productData;


  Future<List<Product>> fetchProductInfo() async {

    var productUrl = Uri.parse('http://10.0.2.2:8000/products/?category=${widget.categoryId}');
    Response response = await http.get(productUrl);
    var  values = jsonDecode(response.body) ;
    print(values.length);
    List<Product> listProducts = [];

    if(response.statusCode == 200){
      if(values.length > 0){
        for(int i = 0; i < values.length; i++){
          Product productToList = Product(id: values[i]['id'], nameProduct: values[i]['product_name'], barCode: values[i]['bar_code'], category: values[i]['category'], imageUrl: values[i]['image_url'], creationDate: DateTime.parse(values[i]['creation_date_product']), isVisible: values[i]['is_visible'], actualPrice: values[i]['price'], supermarket: Supermarket(id: values[i]['supermarket']['id'], nameSupermarket: values[i]['supermarket']['supermarket_name'], city: values[i]['supermarket']['city']['city_name'], street: values[i]['supermarket']['street'], district: values[i]['supermarket']['district'], complement: values[i]['supermarket']['complement']));
          listProducts.add(productToList);
        }
        print(listProducts);
      }
      return listProducts;
    }
    else{
      return listProducts;
    }
  }

  Widget _buildPopUpCard(){
    return Center(
      child: Card(
        elevation: 5,
        child: Container(
          width: 368,
          height: 265,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.only(top: 10, left: 20),
                    child: const Text(
                      'Selecione o supermercado onde você está atualmente',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                  child: Text(
                    'Supermercado*',
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  width: 320,
                  height: 40,
                  margin: EdgeInsets.only(left: 22, top: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Colors.grey)
                  ),
                  child: Container( // COloca a porra de um container no meio dos dropdown items para que eles não bugem.
                    margin: EdgeInsets.only(left: 10),
                    child: DropdownButton(
                        items: [
                          DropdownMenuItem(child: Text('Mercafrutas'), value: "Mercafrutas"),
                          DropdownMenuItem(child: Text('Betel'), value: "Betel"),
                          DropdownMenuItem(child: Text('Comperfrutas'), value: "Comperfrutas"),
                        ],
                        isExpanded: true,
                        elevation: 5,
                        underline: Container( color: Colors.white),
                        iconSize: 40,
                        value: supermarketValue,
                        onChanged: (supermarket) {
                          if (supermarket is String){
                            setState(() {
                              supermarketValue = supermarket;
                              print(supermarketValue);
                            });
                          }
                        }
                    ),
                  ),
                ),
                Container(
                  width: 320,
                  height: 40,
                  margin: EdgeInsets.only(left: 22, top: 20),
                  child:
                  ElevatedButton(
                    child:  Text(
                      'Selecionar',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white
                      ),
                    ),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(98, 0, 238, 30.0)),
                      foregroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                  ),
                )
              ]
          ),
        ),

      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return _buildPopUpCard();
        }
    );
  }

  callFunction(int userId){
    print(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBarMenu(),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBarSearchFeature()
      ),
      body: FutureBuilder(
          future: productData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.length > 0 ? SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 25),
                      child:  Text(
                        '${snapshot.data![0].category}',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                     ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){
                        return  ProductViewInRow(product: snapshot.data![index], func: callFunction,);
                      },
                    ) ,
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                    )
                  ],
                ),
              ) : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child:  Text(
                      'Nenhum produto encontrado nessa categoria',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                  ),
                  smallPurpleButton('Voltar', func: (){
                    Navigator.of(context).popAndPushNamed('/AppHome');
                  })
                ],
              );
            }
            else {
              final error = snapshot.error;
              print(error);
              return CircularProgressIndicator();
            }
          }
      ),
    );
  }
}
