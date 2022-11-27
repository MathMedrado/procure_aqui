import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:procure_aqui/components/listOfProductCard.dart';
import 'package:procure_aqui/components/userInputButton.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product.dart';
import '../models/supermarket.dart';

class listOfProducts extends StatefulWidget {
  const listOfProducts({super.key});

  @override
  State<listOfProducts> createState() => _listOfProductsState();
}

class _listOfProductsState extends State<listOfProducts> {

  @override
  void initState(){
    super.initState();
    productData = fetchProductInfo();
  }

  late Future<List<Product>> productData;

  Future<List<Product>> fetchProductInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userEmail = sharedPreferences.getString('email');
    var userUrl = Uri.parse('http://18.208.163.221/users/?email=$userEmail');
    Response responseUser = await http.get(userUrl);
    print(responseUser.body);
    print('id ${jsonDecode(responseUser.body)[0]['id']}');
    int userid = jsonDecode(responseUser.body)[0]['id'];


    var url = Uri.parse('http://18.208.163.221/listOfProducts/?user=$userid');
    Response response = await http.get(url);
    var  values = jsonDecode(response.body) ;
    List<Product> listProducts = [];
    print(values.length);

    if(response.statusCode == 200 && values.length != 0){
      if(values[0]['products'].length > 0){
        for(int i = 0; i < values[0]['products'].length; i++){
          Product productToList = Product(id: values[0]['products'][i]['id'], nameProduct: values[0]['products'][i]['product_name'], barCode: values[0]['products'][i]['bar_code'], category: values[0]['products'][i]['category'], imageUrl: values[0]['products'][i]['image_url'], creationDate: DateTime.parse(values[0]['products'][i]['creation_date_product']), isVisible: values[0]['products'][i]['is_visible'], actualPrice: values[0]['products'][i]['price'], supermarket: Supermarket(id: values[0]['products'][i]['supermarket']['id'], nameSupermarket: values[0]['products'][i]['supermarket']['supermarket_name'], city: values[0]['products'][i]['supermarket']['city']['city_name'], street: values[0]['products'][i]['supermarket']['street'], district: values[0]['products'][i]['supermarket']['district'], complement: values[0]['products'][i]['supermarket']['complement']));
          print(productToList.getNameProduct);
          listProducts.add(productToList);
          print(listProducts);
        }
        // print('Produtos: ${listProducts}');
      }
      return listProducts;
    }
    else{
      return listProducts;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchProductInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.length != 0 ?  SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(margin: EdgeInsets.only(top: 20),),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      return listOfProductcard(product: snapshot.data![index]);
                    }
                ),
                userInputButton(Colors.blue, 'Limpar Lista', () {
                  Navigator.of(context).pushNamed('/productEditPage');
                }),
                userInputButton(Color(0xFF7B61FF), 'Comparar lista', () {
                  Navigator.of(context).pushNamed('/productComparationPage');
                })
              ],
            ),
          ) : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                    'Você não possui nenhum produto na sua lista de produtos no momento.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17
                  ),
                ),
              ),
            ],
          );
        }
        else {
          final error = snapshot.error;
          print(error);
          return CircularProgressIndicator();
        }
      }
    );
  }
}
