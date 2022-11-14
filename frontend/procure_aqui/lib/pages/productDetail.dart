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
    var url = Uri.parse('http://10.0.2.2:8000/products/?bar_code=${widget.product.getBarCode}');
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
                          'R\$ ${widget.product.getActualPrice}',
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
                      onPressed: () {},
                    ),
                  ),

                  snapshot.data!.length >1 ?Column(
                    children: [
                      Container(
                        width: 330,
                        margin: EdgeInsets.only(left: 30, top: 7),
                        child: const Text(
                          '_______________________________________',
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