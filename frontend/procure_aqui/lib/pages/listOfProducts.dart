import 'package:flutter/material.dart';
import 'package:procure_aqui/components/listOfProductCard.dart';
import 'package:procure_aqui/components/userInputButton.dart';

class listOfProducts extends StatelessWidget {
  const listOfProducts({super.key});



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(margin: EdgeInsets.only(top: 20),),
          listOfProductcard(),
          listOfProductcard(),
          listOfProductcard(),
          listOfProductcard(),
          listOfProductcard(),
          userInputButton(Colors.blue, 'Limpar Lista', (){
            Navigator.of(context).pushNamed('/productEditPage');
          }),
          userInputButton(Color(0xFF7B61FF), 'Comparar lista', (){
            Navigator.of(context).pushNamed('/productComparationPage');
          })
        ],
      ),
    );
  }
}
