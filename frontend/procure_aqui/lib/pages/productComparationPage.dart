import 'package:flutter/material.dart';
import 'package:procure_aqui/components/comparationProductCard.dart';
import 'package:procure_aqui/models/product.dart';


class productComparationPage extends StatelessWidget {
  productComparationPage({ super.key});

  final Product product = Product(id: 1, nameProduct: 'Ervilha De Campinas', barCode: 5689254895486589, categoryId: 1, imageUrl: 'lib/assets/images/bolo.jpeg', creationDate: DateTime.now(), isVisible: true, actualPrice: 5.0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xFF3700B3),
        title: Text('Lista de produtos'),
      ),
      body: Column(
        children: [
          comparationProductCard(product: product)
        ],
      )
    );
  }
}