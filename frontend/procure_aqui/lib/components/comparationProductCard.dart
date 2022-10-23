import 'package:flutter/material.dart';
import 'package:procure_aqui/models/product.dart';

class comparationProductCard extends StatelessWidget {
  const comparationProductCard({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
                margin: EdgeInsets.only( bottom: 12, top: 20),
                width: 379,
                height: 207,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[100]
                ),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 7, left: 15),
                        child: Text(
                          'Supermercado Comperfrutas',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 7, left: 15),
                        child: Text(
                          'Quantidade de produtos Encontrados: 4',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child: Row(
                          children: [
                            Text(
                              'Preço Final:',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              ' R\$ ${product.getActualPrice}',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 178,
                        height: 31,
                        margin: EdgeInsets.only( left: 10, top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Color(0xFF3700B3)),
                          ),
                          child: Text(
                            'Mostrar produtos',
                            style: TextStyle(
                              fontSize: 14
                            ),
                          ),
                          onPressed: (){
                          },
                        ),
                      ),
                      Container(
                        width: 178,
                        height: 31,
                        margin: EdgeInsets.only( left: 10, top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Color(0xFF3700B3)),
                          ),
                          child: Text(
                            'Compartilhar',
                            style: TextStyle(
                              fontSize: 14
                            ),
                          ),
                          onPressed: (){
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
    );
  }
}