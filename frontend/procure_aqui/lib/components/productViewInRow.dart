import 'package:flutter/material.dart';
import 'package:procure_aqui/components/productViewInRow.dart';
import 'package:procure_aqui/models/product.dart';



class ProductViewInRow extends StatelessWidget {
  ProductViewInRow({required this.product, required this.func, super.key});

  final Product product;
  final void Function(int) func;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
          margin: EdgeInsets.only(left: 10, top: 10 ),
          //width: 183,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            width: 200,
            child: Card(
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 134),
                    child: IconButton(
                      icon: Icon(Icons.add) ,
                      onPressed: () => func(product.getId)
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 130,
                      height: 100,
                      child: Image.network(
                        product.getImageUrl,
                          fit: BoxFit.cover
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
                      'R\$ ${product.getActualPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    width: 148,
                    height: 40,
                    padding: EdgeInsets.only(bottom: 10),
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
                  //Container(padding: EdgeInsets.only(bottom: 15),)
                ],
              )
            ),
          ),
        ),
        )
        
      ],
    );
  }
}