import 'package:flutter/material.dart';
import 'package:procure_aqui/models/product.dart';
import 'package:procure_aqui/components/appBarSearchFeature.dart';
import 'package:procure_aqui/components/otherMarketCard.dart';


class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({ required this.product, super.key});
  
  final Product product;
  final String category = 'Vegetal';
  final String supermarket = 'Comperfrutas';
  final String address = 'Av. Bernardo Sayão, 646 - Centro, Rialma - GO';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBarSearchFeature()
      ),
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Center(
                child: Text(
                  product.getNameProduct,
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
                  product.getImageUrl,
                  //'lib/assets/images/bolo.jpeg'
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, top: 20),
              child: Text(
                'Categoria: ${category}',
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
                    'R\$ ${product.getActualPrice.toString()}',
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
                'Supermercado: ${supermarket}',
                 style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              width: 330,
              margin: EdgeInsets.only(left: 30, top: 7),
              child: Text(
                '${address}',
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
            otherMarketCard(product: product),
            otherMarketCard(product: product),
            otherMarketCard(product: product),
            otherMarketCard(product: product)


          ],
        ),
      ),
    );
  }
}