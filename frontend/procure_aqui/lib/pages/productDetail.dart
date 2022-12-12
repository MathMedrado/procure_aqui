import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:procure_aqui/models/product.dart';
import 'package:procure_aqui/components/appBarSearchFeature.dart';
import 'package:procure_aqui/components/otherMarketCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/supermarket.dart';


class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({ required this.product, super.key});
  
  final Product product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {

  @override
  void initState(){
    super.initState();
    productData = fetchProductInfo();
  }

  late Future<List<Product>> productData;

  Future<List<Product>> fetchProductInfo() async {
    var url = Uri.parse('http://18.208.163.221/products/?bar_code=${widget.product.getBarCode}');
    Response response = await http.get(url);
    var  values = jsonDecode(response.body) ;
    List<Product> listProducts = [];

    if(response.statusCode == 200){
      if(values.length > 0){
        for(int i = 0; i < values.length; i++){
          Product productToList = Product(id: values[i]['id'], nameProduct: values[i]['product_name'], barCode: values[i]['bar_code'], category: values[i]['category'], imageUrl: values[i]['image_url'], creationDate: DateTime.parse(values[i]['creation_date_product']), isVisible: values[i]['is_visible'], actualPrice: values[i]['price'], supermarket: Supermarket(id: values[i]['supermarket']['id'], nameSupermarket: values[i]['supermarket']['supermarket_name'], city: values[i]['supermarket']['city']['city_name'], street: values[i]['supermarket']['street'], district: values[i]['supermarket']['district'], complement: values[i]['supermarket']['complement']));
          listProducts.add(productToList);
        }
        print('Produtos: ${listProducts}');
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
      print('Não tem produtos na lista');
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
      print('Já está na lista');


    }else{
      print('Não está na lista');
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
      var url = Uri.parse('http://18.208.163.221/update_list_products/list/$listId/products/$listOfProductsId');
      print(url);
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
      "products" : listOfOneProduct.toString()
    });
    print(response.statusCode);
    print(response.body);
    final snackBar = SnackBar(content: Text("Produto adicionado para a lista de compras!", textAlign: TextAlign.center), backgroundColor: Colors.green,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBarSearchFeature()
      ),
      body: FutureBuilder(
        future: productData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Center(
                        child: Text(
                          widget.product.getNameProduct,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        )
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 35),
                      width: 257,
                      height: 200,
                      child: Image.network(
                          widget.product.getImageUrl
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, top: 20),
                    child: Text(
                      'Categoria: ${widget.product.category}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 30, top: 7),
                        child: Text(
                          'Preço: ',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 2, top: 7),
                        child: Text(
                          'R\$ ${widget.product.getActualPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, top: 7),
                    child: Text(
                      'Supermercado: ${widget.product.supermarket
                          .getNameSupermarket}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    width: 330,
                    margin: EdgeInsets.only(left: 30, top: 7),
                    child: Text(
                      '${widget.product.supermarket.getStreet}, ${widget.product
                          .supermarket.getDistrict}, ${widget.product
                          .supermarket.getComplement} ',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    width: 160,
                    height: 35,
                    margin: EdgeInsets.only(left: 30, top: 25),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Color(
                              0xFF3700B3))
                      ),
                      child: Text('Adicionar a lista'),
                      onPressed: () {
                        callFunction(widget.product.getId);
                      },
                    ),
                  ),

                  snapshot.data!.length >1 ?Column(
                    children: [
                      Container(
                        width: 330,
                        margin: EdgeInsets.only(left: 30, top: 7),
                        child: const Text(
                          '__________________________________',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Container(
                        width: 330,
                        margin: EdgeInsets.only(left: 30, top: 7, bottom: 20),
                        child: const Center(
                          child: Text(
                            'Compare este produto em outros supermercados',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index){
                          return snapshot.data![index].getId != widget.product.getId? otherMarketCard(product: snapshot.data![index]) : Container();
                        },
                      )
                    ],
                  ): Container()
                ] ,
              ),
            );
        }
        else {
         final error = snapshot.error;
         print(error);
         return CircularProgressIndicator();
         }
      }
      )
      );
  }
}