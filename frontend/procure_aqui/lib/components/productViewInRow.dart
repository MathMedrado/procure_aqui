import 'package:flutter/material.dart';
import 'package:procure_aqui/components/productViewInRow.dart';
import 'package:procure_aqui/models/product.dart';



class ProductViewInRow extends StatelessWidget {
  ProductViewInRow({required this.product, super.key});

  final Product product;


  @override
  Widget build(BuildContext context) {
    return Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, top: 10 ),
              width: 183,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Card(
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 140),
                      child: IconButton(
                        icon: Icon(Icons.add) ,
                        onPressed: (){}
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 146,
                        height: 106,
                        child: Image.asset(
                          product.getImageUrl,
                          //'lib/assets/images/bolo.jpeg'
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 5),
                      child: Text(
                        product.getNameProduct,
                        style: TextStyle(
                          fontSize: 14
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only( left: 20, top: 5),
                      child: Text(
                        'R\$ ${product.getActualPrice.toString()}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                      width: 148,
                      height: 30,
                      margin: EdgeInsets.only( left: 10, top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Color(0xFF7B61FF)),
                        ),
                        child: Text(
                          'Ver detalhes'
                        ),
                        onPressed: (){
                          Navigator.of(context).pushNamed('/ProductDetailPage',arguments: product);
                        },
                      ),
                    ),
                    Container(padding: EdgeInsets.only(bottom: 15),)
                  ],
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 10 ),
              width: 183,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 140),
                      child: IconButton(
                        icon: Icon(Icons.add) ,
                        onPressed: (){}
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 146,
                        height: 106,
                        child: Image.asset(
                          product.getImageUrl,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 5),
                      child: Text(
                        product.getNameProduct,
                        style: TextStyle(
                          fontSize: 14
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only( left: 20, top: 5),
                      child: Text(
                        'R\$ ${product.getActualPrice.toString()}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                      width: 148,
                      height: 30,
                      margin: EdgeInsets.only( left: 10, top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Color(0xFF7B61FF)),
                        ),
                        child: Text(
                          'Ver detalhes'
                        ),
                        onPressed: (){
                          Navigator.of(context).pushNamed('/ProductDetailPage', arguments: product);
                        },
                      ),
                    ),
                    Container(padding: EdgeInsets.only(bottom: 15),)
                  ],
                )
              ),
            ),

          ],
        );
  }
}