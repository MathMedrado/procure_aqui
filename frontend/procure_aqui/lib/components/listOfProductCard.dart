import 'package:flutter/material.dart';
import 'package:procure_aqui/models/product.dart';

class listOfProductcard extends StatelessWidget {
   listOfProductcard ({ super.key});

  final Product product = Product(id: 1, nameProduct: 'Ervilha De Campinas', barCode: 5689254895486589, categoryId: 1, imageUrl: 'lib/assets/images/bolo.jpeg', creationDate: DateTime.now(), isVisible: true, actualPrice: 5.0);
  final Product product2 = Product(id: 1, nameProduct: 'Ervilha da Coreia', barCode: 5689254895486589, categoryId: 1, imageUrl: 'lib/assets/images/bolo.jpeg', creationDate: DateTime.now(), isVisible: true, actualPrice: 5.0);
  final Product product3 = Product(id: 1, nameProduct: 'Ervilha do Japão, China, Chile e Uruaia', barCode: 5689254895486589, categoryId: 1, imageUrl: 'lib/assets/images/bolo.jpeg', creationDate: DateTime.now(), isVisible: true, actualPrice: 5.0);

  final String supermarket = 'Comperfrutas';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
                margin: EdgeInsets.only( bottom: 12),
                width: 379,
                height: 153,
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
                        child: Image.asset(
                          product.getImageUrl,
                          //'lib/assets/images/bolo.jpeg'
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
                                  ' R\$ ${product.getActualPrice}',
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
                                  ' R\$ ${product.getActualPrice}',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 120,
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
                                'Ver detalhes',
                                style: TextStyle(
                                  fontSize: 12
                                ),
                              ),
                              onPressed: (){
                                Navigator.of(context).pushNamed('/ProductDetailPage', arguments: product);
                              },
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        child: IconButton(
                          onPressed: (){
                            print('working');
                          }, 
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