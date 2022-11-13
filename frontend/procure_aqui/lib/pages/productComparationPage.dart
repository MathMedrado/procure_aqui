import 'package:flutter/material.dart';
import 'package:procure_aqui/components/comparationProductCard.dart';
import 'package:procure_aqui/models/product.dart';
import 'package:procure_aqui/models/supermarket.dart';


class productComparationPage extends StatelessWidget {
  productComparationPage({ super.key});

  final Product product = Product(id: 1, nameProduct: 'Ervilha De Campinas', barCode: 5689254895486589, category: 'Queijo', imageUrl: 'lib/assets/images/bolo.jpeg', creationDate: DateTime.now(), isVisible: true, actualPrice: 5.0, supermarket: Supermarket(id: 1, nameSupermarket: 'Mercafrutas', city: 'Rialma', street: '68', district: 'Park Industrial', complement: 'Quadra 18'));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xFF3700B3),
        title: Text('Lista de produtos'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            comparationProductCard(product: product),
            comparationProductCard(product: product),
            comparationProductCard(product: product),
            comparationProductCard(product: product),
            comparationProductCard(product: product),
            comparationProductCard(product: product)
          ],
        ),
      )
    );
  }
}