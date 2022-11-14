import 'package:flutter/material.dart';
import 'package:procure_aqui/models/product.dart';

class otherMarketCard extends StatelessWidget {
  const otherMarketCard({required this.product, super.key});

  final Product product;
  final String supermarket = 'Comperfrutas';

  @override
  Widget build(BuildContext context) {
    return Container(
              margin: EdgeInsets.only(left: 25, bottom: 12),
              width: 361,
              height: 148,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[100]
              ),
              child: Card(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: 120,
                      height: 120,
                      child: Image.network(
                        product.getImageUrl,
                        //'lib/assets/images/bolo.jpeg'
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200,
                          margin: EdgeInsets.only(top: 7, left: 15),
                          child: Text(
                            product.getNameProduct,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15, top: 10),
                          child: Text(
                            product.supermarket.getNameSupermarket,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only( left: 10, top: 10),
                              child: Text(
                                'R\$ ${product.getActualPrice.toString()}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Container(
                              width: 120,
                              height: 40,
                              margin: EdgeInsets.only( left: 10, top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Color(0xFF3700B3)),
                                ),
                                child: Text(
                                  'Ver detalhes',
                                  style: TextStyle(
                                    fontSize: 12
                                  ),
                                ),
                                onPressed: (){
                                  Navigator.of(context).pushNamed('/ProductDetailPage',arguments: product);
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
  }
}