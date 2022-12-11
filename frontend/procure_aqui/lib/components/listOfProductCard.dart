import 'package:flutter/material.dart';
import 'package:procure_aqui/models/productWithPriceDetail.dart';

import '../models/supermarket.dart';

class listOfProductcard extends StatelessWidget {
   listOfProductcard ({required this.product, required this.func, super.key});
   ProductWithPrice product;
   final void Function(int) func;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
                margin: EdgeInsets.only( bottom: 12),
                width: 379,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[100]
                ),
                child: Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        width: 120,
                        height: 150,
                        child: Image.network(
                          product.getImageUrl,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 176,
                            margin: EdgeInsets.only(top: 7, left: 15),
                            child: Text(
                              product.getNameProduct,
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.grey
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15, top: 10),
                            child: Row(
                              children: [
                                Text(
                                  'Preço médio:',
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  ' R\$ ${product.getAveragePrice.toStringAsFixed(2)}',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15, top: 10),
                            child: Row(
                              children: [
                                Text(
                                  'Menor preço:',
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  ' R\$ ${product.getMinimunPrice.toStringAsFixed(2)}',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 120,
                            height: 31,
                            margin: EdgeInsets.only( left: 10, top: 10, bottom: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Color(0xFF7B61FF)),
                              ),
                              child: Text(
                                'Ver detalhes',
                                style: TextStyle(
                                  fontSize: 12
                                ),
                              ),
                              onPressed: (){
                                Navigator.of(context).pushNamed('/ProductDetailWithPricePage', arguments: product);
                              },
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        child: IconButton(
                          onPressed: ()  => func(product.getId), 
                          icon: Icon(
                            Icons.delete_outline_rounded,
                            size: 25,
                            
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
    );
  }
}