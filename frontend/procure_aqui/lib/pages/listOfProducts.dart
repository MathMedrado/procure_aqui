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
  int restartPage = 0;


  Future<List<Product>> fetchProductInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userEmail = sharedPreferences.getString('email');
    var userUrl = Uri.parse('http://18.208.163.221/users/?search=$userEmail');
    print(userEmail);
    Response responseUser = await http.get(userUrl);
    print(responseUser.body);
    print('id ${jsonDecode(responseUser.body)[0]['id']}');
    int userid = jsonDecode(responseUser.body)[0]['id'];
    await sharedPreferences.setInt('userId', userid);



    var url = Uri.parse('http://18.208.163.221/listOfProducts/?user=$userid');
    Response response = await http.get(url);
    print(response.body);
    var  values = jsonDecode(response.body) ;

    List<Product> listProducts = [];
    print(values.length);

    if(response.statusCode == 200 && values.length != 0){
      if(values[0]['products'].length > 0){
        for(int i = 0; i < values[0]['products'].length; i++){
          String utf8convert(String text) {
            List<int> bytes = text.toString().codeUnits;
            return utf8.decode(bytes);
          }
          String productNameConverted = utf8convert(values[0]['products'][i]['product_name']);
          String categoryNameConverted = utf8convert(values[0]['products'][i]['category']);
          String supermarketNameConverted = utf8convert(values[0]['products'][i]['supermarket']['supermarket_name']);
          String supermarketStreet = utf8convert(values[0]['products'][i]['supermarket']['city']['city_name']);
          String supermarketDistrict = utf8convert(values[0]['products'][i]['supermarket']['district']);
          String supermarketCity= utf8convert(values[0]['products'][i]['supermarket']['city']['city_name']);
          String supermarketComplement = utf8convert(values[0]['products'][i]['supermarket']['complement']);
          
          Product productToList = Product(id: values[0]['products'][i]['id'], nameProduct: productNameConverted, barCode: values[0]['products'][i]['bar_code'], category: categoryNameConverted, imageUrl: values[0]['products'][i]['image_url'], creationDate: DateTime.parse(values[0]['products'][i]['creation_date_product']), isVisible: values[0]['products'][i]['is_visible'], actualPrice: values[0]['products'][i]['price'], supermarket: Supermarket(id: values[0]['products'][i]['supermarket']['id'], nameSupermarket: supermarketNameConverted, city: supermarketCity, street: supermarketStreet, district: supermarketDistrict, complement: supermarketComplement));
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

  
  // Future<List<Product>> fetchProductInfo() async {

  //   var productUrl = Uri.parse('http://18.208.163.221/products/');
  //   Response response = await http.get(productUrl);
  //   var  values = jsonDecode(response.body) ;
  //   print(values.length);
  //   List<Product> listProducts = [];

  //   if(response.statusCode == 200){
  //     if(values.length > 0){
  //       for(int i = 0; i < values.length; i++){
  //         String utf8convert(String text) {
  //           List<int> bytes = text.toString().codeUnits;
  //           return utf8.decode(bytes);
  //         }
  //         String productNameConverted = utf8convert(values[i]['product_name']);
  //         String categoryNameConverted = utf8convert(values[i]['category']);
  //         String supermarketNameConverted = utf8convert(values[i]['supermarket']['supermarket_name']);
  //         String supermarketStreet = utf8convert(values[i]['supermarket']['street']);
  //         String supermarketDistrict = utf8convert(values[i]['supermarket']['district']);
  //         String supermarketCity= utf8convert(values[i]['supermarket']['city']['city_name']);
  //         String supermarketComplement = utf8convert(values[i]['supermarket']['complement']);
  //         Product productToList = Product(id: values[i]['id'], nameProduct: productNameConverted, barCode: values[i]['bar_code'], category: categoryNameConverted, imageUrl: values[i]['image_url'], creationDate: DateTime.parse(values[i]['creation_date_product']), isVisible: values[i]['is_visible'], actualPrice: values[i]['price'], supermarket: Supermarket(id: values[i]['supermarket']['id'], nameSupermarket: supermarketNameConverted, city: supermarketCity, street: supermarketStreet, district: supermarketDistrict, complement: supermarketComplement));
          
  //         listProducts.add(productToList);
  //       }
  //       print(listProducts);
  //     }
  //     return listProducts;
  //   }
  //   else{
  //     return listProducts;
  //   }
  // }

  deleteSelectProduct(int productId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? userId = sharedPreferences.getInt('userId');
    print('funciona $productId');
    print('id do usuário: $userId');
    var url = Uri.parse('http://18.208.163.221/listOfProducts/?user=$userId');
    Response response = await http.get(url);
    var  values = jsonDecode(response.body) ;
    int listId = values[0]['id'];
    
    List<int> list = [];

    if(values.length == 0){
      //print('Não tem produtos na lista');
    } else {
      //print('Quantidade de produtos: ${values[0]}');
      for(int x = 0; x < values[0]['products'].length; x++){
        list.add(values[0]['products'][x]['id']);
      }
      //print(list);
    }
    list.remove(productId);
    print(list);
    if(list.length > 0){
      var urlPut = Uri.parse('http://18.208.163.221/update_list_products/list/$listId/products/$list');
      Response responsePut = await http.put(urlPut);
    } else{
      deleteAllProducts();
    }
    setState(() {
      restartPage = 0;
    });

  }

  deleteAllProducts() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userEmail = sharedPreferences.getString('email');
    var userUrl = Uri.parse('http://18.208.163.221/users/?search=$userEmail');
    Response responseUser = await http.get(userUrl);
    int userid = jsonDecode(responseUser.body)[0]['id'];
    var urlList = Uri.parse('http://18.208.163.221/listOfProducts/?user=$userid');
    Response responseList = await http.get(urlList);
    var  values = jsonDecode(responseList.body);
    print('Erro aqui heloo $values');
    int listId = values[0]['id'];
    var url = Uri.parse('http://18.208.163.221/listOfProducts/$listId/');
    print(url);
    var response = await http.delete(url);
    print(response.body);
    setState(() {
      restartPage = 0;
    });
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
                    physics: const NeverScrollableScrollPhysics(), 
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      return listOfProductcard(product: snapshot.data![index], func: deleteSelectProduct);
                    }
                ),
                userInputButton(Colors.blue, 'Limpar Lista', () async {
                  deleteAllProducts();
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
