import 'package:flutter/material.dart';
import 'package:procure_aqui/components/smallPurpleButton.dart';
import 'package:procure_aqui/models/product.dart';

class productEditPage extends StatefulWidget {
  const productEditPage({super.key});

  @override
  State<productEditPage> createState() => _productEditPageState();
}

class _productEditPageState extends State<productEditPage> {

  Product product = Product(id: 1, nameProduct: 'Ervilha De Campinas', barCode: 5689254895486589, categoryId: 1, imageUrl: 'lib/assets/images/bolo.jpeg', creationDate: DateTime.now(), isVisible: true, actualPrice: 5.0);
  final productPriceController = TextEditingController();

  _submitAlterValue(){
    double? productPrice = double.tryParse(productPriceController.text);

    print(productPrice);

  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xFF3700B3),
        title: Text('Alteração de preço'),
      ),
      body: Column(
        children: [
          Container(margin: EdgeInsets.only(top: 20),),
          Container(
            child: Text(
              product.getNameProduct,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 30),
            width: 257,
            height: 200,
            child: Image.asset(
              product.getImageUrl,
              //'lib/assets/images/bolo.jpeg'
            ),
          ),
          Container(
            margin: EdgeInsets.only( top: 20),
            child: Text(
              'Preço Atual: R\$ ${product.actualPrice}',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(33, 20, 0, 5),
                child: Text('Preço do produto*: ')
              ),
              Container(
                height: 50,
                width: 350,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: TextField(
                  controller: productPriceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4)
                    )
                  ),

                ),
              ),
              Container(margin: EdgeInsets.only(bottom: 150),),
              Row(
                children: [
                  smallPurpleButton('Cadastrar', func: _submitAlterValue),
                  smallPurpleButton('Cancelar', func: () {  },),
                ],
              )

            ],
          )
        ],
      ),
    );
  }
}