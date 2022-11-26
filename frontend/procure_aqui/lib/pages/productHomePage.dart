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

    var productUrl = Uri.parse('http://10.0.2.2:8000/products/');
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

  Future<List<int>>  fetchUserListOfProducts() async {
    SharedPreferences sharedPreferences =  await SharedPreferences.getInstance();
    String? userEmail = sharedPreferences.getString('email');
    var userUrl = Uri.parse('http://10.0.2.2:8000/users/?search=$userEmail');
    Response responseUser = await http.get(userUrl);
    //print(responseUser.body);
    //print('id: 2 ${jsonDecode(responseUser.body)[0]['id']}');
    int userid = jsonDecode(responseUser.body)[0]['id'];
    print(jsonDecode(responseUser.body)[0]['id']);
    await sharedPreferences.setInt('userId', userid);


    var url = Uri.parse('http://10.0.2.2:8000/listOfProducts/?user=$userid');
    Response response = await http.get(url);
    print(response.body);
    var  values = jsonDecode(response.body) ;
    List<int> list = [];

    if(values.length == 0){
      print('Não tem produtos na lista');
    }else{
      print('Quantidade de produtos: ${values[0]}');
      for(int x = 0; x < values[0]['products'].length; x++){
        //print(values[0]['products'][x]['id']);
        list.add(values[0]['products'][x]['id']);
      }
      print(list);
    }


    return list;
  }

  callFunction(int productId)  {
    List<int> listOfProductsId = [];
    fetchUserListOfProducts().then((List<int>value)  {
      //print('Erro $value');
      listOfProductsId = value;
      if(listOfProductsId.isNotEmpty){
        callFunctionPut(listOfProductsId, productId);
      }else{
        callFunctionPost(productId);
      }
    }
    );

  }

  callFunctionPut(List<int> listOfProductsId, int productId) async {

    if(listOfProductsId.contains(productId)){
      print('Já está na lista');


    }else{
      print('Não está na lista');
      //print(listOfProductsId);
      //print(productId);
      SharedPreferences sharedPreferences =  await SharedPreferences.getInstance();
      String? userEmail = sharedPreferences.getString('email');
      var userUrl = Uri.parse('http://10.0.2.2:8000/users/?search=$userEmail');
      Response responseUser = await http.get(userUrl);
      print(responseUser.body);
      int userId = jsonDecode(responseUser.body)[0]['id'];
      //print(responseUser.body);
      //print('id: 2 ${jsonDecode(responseUser.body)[0]['id']}');
      // int userid = jsonDecode(responseUser.body)[0]['id'];
      print('usuario $userId');
      print(toJson(userId!, listOfProductsId));
      var url = Uri.parse('http://10.0.2.2:8000/listOfProducts/1/');
      print(json.encode(toJson(userId!, listOfProductsId)));
      print(listOfProductsId.toString());
      final sendbody = {
        "user": "$userId", "products" : listOfProductsId
      };
      Response response = await http.put(url, body: jsonEncode(sendbody), headers: {
        'Content-Type' : 'application/json',

      });
      print(response.statusCode);
      print(response.body);
      

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
    var url = Uri.parse('http://10.0.2.2:8000/listOfProducts/');
    Response response = await http.post(url, body: {
      "user" : userId,
      "products" : listOfOneProduct
    });
    print(response.statusCode);
    print(response.body);

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
                      'Últimos produtos cadastrados',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: (150.0 / 210.0),
                        crossAxisCount: 2
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      return ProductViewInRow(product: snapshot.data![index], func: callFunction,);
                    },
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
            return CircularProgressIndicator();
          }
        }
    );
  }



  @override
  Widget build(BuildContext context) {
    return renderScreen();

  }
}

// ElevatedButton( Botão que cria o popup
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