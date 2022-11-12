import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:procure_aqui/models/product.dart';
import 'package:procure_aqui/components/appBarSearchFeature.dart';
import 'package:procure_aqui/components/otherMarketCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


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
  late Future<Map> productData;
  final String category = 'Vegetal';
  final String supermarket = 'Comperfrutas';
  final String address = 'Av. Bernardo Sayão, 646 - Centro, Rialma - GO';

  Future<Map> fetchProductInfo() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String? userEmail = sharedPreferences.getString('email');
    var url = Uri.parse('http://10.0.2.2:8000/products/62/');
    var response = await http.get(url);
    print(response.body);

    if(response.statusCode == 200){
      return {
        // 'id' : jsonDecode(response.body)['id'],
        'nameProduct' : jsonDecode(response.body)['product_name'],
        // 'barCode' : jsonDecode(response.body)['bar_code'],
        'category' : jsonDecode(response.body)['category'],
        // 'imageUrl': jsonDecode(response.body)['image_url'],
        // 'creationDate' : jsonDecode(response.body)['creation_date'],
        // 'isVisible' : jsonDecode(response.body)['is_visible'],
        // //'actualPrice' : jsonDecode(response.body)['actual_price'],
        'actualPrice' : 50.0,
        // 'supermarket' : supermarket
        'supermarket' : jsonDecode(response.body)['supermarket'][0]['supermarket_name'] ,
        'supermarketAddress' : jsonDecode(response.body)['supermarket'][0]['street'],
        'supermarketDistrict' : jsonDecode(response.body)['supermarket'][0]['district'],
        'supermarketComplement' : jsonDecode(response.body)['supermarket'][0]['complement']
      };
      //return Product(id: jsonDecode(response.body)['id'], nameProduct: jsonDecode(response.body)['product_name'], barCode: jsonDecode(response.body)['bar_code'], categoryId: jsonDecode(response.body)['category_id'], imageUrl: jsonDecode(response.body)['image_url'], creationDate: jsonDecode(response.body)['creation_date_product'], isVisible: jsonDecode(response.body)['is_visible'], actualPrice: jsonDecode(response.body)['actual_price']);
    }
    else{
      return {};
     // return Product(id: jsonDecode(response.body)['id'], nameProduct: jsonDecode(response.body)['product_name'], barCode: jsonDecode(response.body)['bar_code'], categoryId: jsonDecode(response.body)['category_id'], imageUrl: jsonDecode(response.body)['image_url'], creationDate: jsonDecode(response.body)['creation_date_product'], isVisible: jsonDecode(response.body)['is_visible'], actualPrice: jsonDecode(response.body)['actual_price']);
    }

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
        builder: (context, snapshot){
          if(snapshot.hasData){
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Center(
                        child: Text(
                          snapshot.data!['nameProduct'],
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
                      child: Image.asset(
                        //snapshot.data!['image_url'],
                        'lib/assets/images/bolo.jpeg'
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, top: 20),
                    child: Text(
                      'Categoria: ${snapshot.data!['category']}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only( left: 30, top: 7),
                        child: Text(
                          'Preço: ',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only( left: 2, top: 7),
                        child: Text(
                          'R\$ ${snapshot.data!['actualPrice']}',
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
                      'Supermercado: ${snapshot.data!['supermarket']}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    width: 330,
                    margin: EdgeInsets.only(left: 30, top: 7),
                    child: Text(
                      '${snapshot.data!['supermarketAddress']}, ${snapshot.data!['supermarketDistrict']}, ${snapshot.data!['supermarketComplement']} ',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    width: 160,
                    height: 35,
                    margin: EdgeInsets.only(left: 30, top: 25),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:  MaterialStatePropertyAll(Color(0xFF3700B3))
                      ),
                      child: Text('Adicionar a lista'),
                      onPressed: (){},
                    ),
                  ),
                  Container(
                    width: 330,
                    margin: EdgeInsets.only(left: 30, top: 7),
                    child: const Text(
                      '___________________________________',
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
                  // otherMarketCard(product: widget.product),
                  // otherMarketCard(product: widget.product),
                  // otherMarketCard(product: widget.product),
                  // otherMarketCard(product: widget.product)
                ],
              ),
            );
          }
          else{
            final error = snapshot.error;
            print(error);
            return  CircularProgressIndicator();
          }
        },
      )
    );
  }
}