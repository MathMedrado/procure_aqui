import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:procure_aqui/models/supermarket.dart';
import 'package:procure_aqui/models/product.dart';
import 'package:procure_aqui/components/productViewInRow.dart';
import 'package:procure_aqui/pages/listOfProducts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:procure_aqui/token.dart';

class productHomePage extends StatefulWidget {
   productHomePage({super.key});

  @override
  State<productHomePage> createState() => _productHomePageState();
}



class _productHomePageState extends State<productHomePage> {

  String? supermarketValue;


  @override
  void initState(){
    super.initState();
    productData = fetchProductInfo();

  }
  late Future<List<Product>> productData;
  bool loading = true;


  Future<List<Product>> fetchProductInfo() async {

    var productUrl = Uri.parse('http://18.208.163.221/products/');
    Response response = await http.get(productUrl);
    var  values = jsonDecode(response.body) ;
    print(values.length);
    List<Product> listProducts = [];

    if(response.statusCode == 200){
      if(values.length > 0){
        for(int i = 0; i < values.length; i++){
          String utf8convert(String text) {
            List<int> bytes = text.toString().codeUnits;
            return utf8.decode(bytes);
          }
          String productNameConverted = utf8convert(values[i]['product_name']);
          String categoryNameConverted = utf8convert(values[i]['category']);
          String supermarketNameConverted = utf8convert(values[i]['supermarket']['supermarket_name']);
          String supermarketStreet = utf8convert(values[i]['supermarket']['street']);
          String supermarketDistrict = utf8convert(values[i]['supermarket']['district']);
          String supermarketCity= utf8convert(values[i]['supermarket']['city']['city_name']);
          String supermarketComplement = utf8convert(values[i]['supermarket']['complement']);
          Product productToList = Product(id: values[i]['id'], nameProduct: productNameConverted, barCode: values[i]['bar_code'], category: categoryNameConverted, imageUrl: values[i]['image_url'], creationDate: DateTime.parse(values[i]['creation_date_product']), isVisible: values[i]['is_visible'], actualPrice: values[i]['price'], supermarket: Supermarket(id: values[i]['supermarket']['id'], nameSupermarket: supermarketNameConverted, city: supermarketCity, street: supermarketStreet, district: supermarketDistrict, complement: supermarketComplement));
          
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

  Future<List<int>>  fetchUserListOfProducts() async {
    SharedPreferences sharedPreferences =  await SharedPreferences.getInstance();
    String? userEmail = sharedPreferences.getString('email');
    var userUrl = Uri.parse('http://18.208.163.221/users/?search=$userEmail');
    Response responseUser = await http.get(userUrl);
    //print(responseUser.body);
    //print('id:  ${jsonDecode(responseUser.body)[0]['id']}');
    int userid = jsonDecode(responseUser.body)[0]['id'];
    print(jsonDecode(responseUser.body)[0]['id']);
    await sharedPreferences.setInt('userId', userid);


    var url = Uri.parse('http://18.208.163.221/listOfProducts/?user=$userid');
    Response response = await http.get(url);
    print(response.body);
    var  values = jsonDecode(response.body) ;
    List<int> list = [];

    if(values.length == 0){
      print('N??o tem produtos na lista');
    }else{
      print('Quantidade de produtos: ${values[0]}');
      for(int x = 0; x < values[0]['products'].length; x++){
        //print(values[0]['products'][x]['id']);
        print(values[0]['products'][x]['id']);
        list.add(values[0]['products'][x]['id']);
      }
      print(list);
    }
    
    return list;
  }

  returnListId(int userid) async {
    var urlList = Uri.parse('http://18.208.163.221/listOfProducts/?user=$userid');
    Response response = await http.get(urlList);
    print(response.body);
    var  values = jsonDecode(response.body) ;
    int listId = values[0]['id'];
    return listId;
  }

  callFunction(int productId)  {
    List<int> listOfProductsId = [];
    fetchUserListOfProducts().then((List<int>value)  {
      print('Erro $value');
      listOfProductsId = value;
      if(listOfProductsId.isNotEmpty){
        print('o product id e $productId');
        callFunctionPut(listOfProductsId, productId);
      }else{
        callFunctionPost(productId);
      }
    }
    );

  }

  callFunctionPut(List<int> listOfProductsId, int productId) async {

    if(listOfProductsId.contains(productId)){
      print('J?? est?? na lista');


    }else{
      print('N??o est?? na lista');
      print(listOfProductsId);
      print(productId);
      listOfProductsId.add(productId);
      print(listOfProductsId);
      SharedPreferences sharedPreferences =  await SharedPreferences.getInstance();
      String? userEmail = sharedPreferences.getString('email');
      var userUrl = Uri.parse('http://18.208.163.221/users/?search=$userEmail');
      Response responseUser = await http.get(userUrl);
      print(responseUser.body);
      int userId = jsonDecode(responseUser.body)[0]['id'];
      var urlList = Uri.parse('http://18.208.163.221/listOfProducts/?user=$userId');
      Response responseList = await http.get(urlList);
      print(responseList.body);
      var  values = jsonDecode(responseList.body) ;
      int listId = values[0]['id'];
      //print(responseUser.body);
      //print('id: 2 ${jsonDecode(responseUser.body)[0]['id']}');
      // int userid = jsonDecode(responseUser.body)[0]['id'];
      print('usuario $userId');
      print(toJson(userId!, listOfProductsId));
      var url = Uri.parse('http://18.208.163.221/update_list_products/list/$listId/products/$listOfProductsId');
      print(url);
      //(json.encode(toJson(userId!, listOfProductsId)));
      print(listOfProductsId);
      // final sendbody = {
      //   "user": "$userId", "products" : listOfProductsId
      // };
      Response response = await http.put(url);
      print(response.statusCode);
      print(response.body);
      if(response.statusCode == 201){
        final snackBar = SnackBar(content: Text("Produto adicionado para a lista de compras!", textAlign: TextAlign.center), backgroundColor: Colors.green,);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
  callFunctionPost(int productId) async {
    print('funcao post chamada');
    List<int> listOfOneProduct = [];
    listOfOneProduct.add(productId);
    SharedPreferences sharedPreferences =  await SharedPreferences.getInstance();
    int? userId = sharedPreferences.getInt('userId');
    print(userId);
    print(listOfOneProduct);
    var url = Uri.parse('http://18.208.163.221/listOfProducts/');
    Response response = await http.post(url, body: {
      "user" : userId.toString(),
      "products" : "$listOfOneProduct"
    });
    print(response.statusCode);
    print(response.body);
    final snackBar = SnackBar(content: Text("Produto adicionado para a lista de compras!", textAlign: TextAlign.center), backgroundColor: Colors.green,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }

  Map toJson(int userId, List<int> listOfProductsId){
    return {
      "user" : userId.toString(),
      "products" : listOfProductsId.toString()
    };
  }



  Widget renderScreen(){
    return FutureBuilder(
        future: productData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30, left: 25),
                    child: const Text(
                      '??ltimos produtos cadastrados',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(), 
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: (150.0 / 210.0),
                            crossAxisCount: 2
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index){
                          return ProductViewInRow(product: snapshot.data![index], func: callFunction,);
                        },
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                  )
                ],
              ),
            );
          }
          else {
            final error = snapshot.error;
            print(error);
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }



  @override
  Widget build(BuildContext context) {
    return renderScreen();

  }
}

// ElevatedButton( Bot??o que cria o popup
//                   child: Text(
//                     'Selecionar',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white
//                     ),
//                   ),
//                   onPressed: () => _dialogBuilder(context),
//                   style: ButtonStyle(
//                           backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(98, 0, 238, 30.0)),
//                           foregroundColor: MaterialStatePropertyAll(Colors.white),          
//                           ),
//                 );