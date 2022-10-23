import 'package:flutter/material.dart';
import 'package:procure_aqui/models/supermarket.dart';
import 'package:procure_aqui/models/product.dart';
import 'package:procure_aqui/components/productViewInRow.dart';

class productHomePage extends StatefulWidget {
  const productHomePage({super.key});

  @override
  State<productHomePage> createState() => _productHomePageState();
}



class _productHomePageState extends State<productHomePage> {

  String? supermarketValue;
  Product product = Product(id: 1, nameProduct: 'Ervilha De Campinas', barCode: 5689254895486589, categoryId: 1, imageUrl: 'lib/assets/images/bolo.jpeg', creationDate: DateTime.now(), isVisible: true, actualPrice: 5.0);
  Product product2 = Product(id: 1, nameProduct: 'Ervilha da Coreia', barCode: 5689254895486589, categoryId: 1, imageUrl: 'lib/assets/images/bolo.jpeg', creationDate: DateTime.now(), isVisible: true, actualPrice: 5.0);
  Product product3 = Product(id: 1, nameProduct: 'Ervilha do Japão, China, Chile e Uruaia', barCode: 5689254895486589, categoryId: 1, imageUrl: 'lib/assets/images/bolo.jpeg', creationDate: DateTime.now(), isVisible: true, actualPrice: 5.0);



  Widget _buildPopUpCard(){
    return Center(
      child: Card(
        elevation: 5,
        child: Container(
          width: 368,
          height: 265,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'Selecione o supermercado onde você está atualmente',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                child: Text(
                  'Supermercado*',
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                width: 320,
                height: 40,
                margin: EdgeInsets.only(left: 22, top: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.grey)
                ),
                child: Container( // COloca a porra de um container no meio dos dropdown items para que eles não bugem.
                  margin: EdgeInsets.only(left: 10),
                  child: DropdownButton(
                    items: [
                      DropdownMenuItem(child: Text('Mercafrutas'), value: "Mercafrutas"),
                      DropdownMenuItem(child: Text('Betel'), value: "Betel"),
                      DropdownMenuItem(child: Text('Comperfrutas'), value: "Comperfrutas"),
                    ],
                    isExpanded: true,
                    elevation: 5,
                    underline: Container( color: Colors.white),
                    iconSize: 40,
                    value: supermarketValue,
                    onChanged: (supermarket) {
                      if (supermarket is String){
                        setState(() {
                          supermarketValue = supermarket;
                          print(supermarketValue);
                        });
                      }
                    }
                  ),
                ),
              ),
              Container(
                width: 320,
                height: 40,
                margin: EdgeInsets.only(left: 22, top: 20),
                child: 
                  ElevatedButton(
                    child:  Text(
                      'Selecionar',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),
                    ),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(98, 0, 238, 30.0)),
                            foregroundColor: MaterialStatePropertyAll(Colors.white),          
                            ),
                  ),
              )
            ]
          ),
        ),

      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context){
    return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return _buildPopUpCard();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30, left: 25),
            child: const Text(
              'Ultimos produtos Cadastrados',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
          ProductViewInRow(product: product),
          ProductViewInRow(product: product2),
          ProductViewInRow(product: product3),

          Container(
            margin: EdgeInsets.only(bottom: 20),
          )
        ],
      ),
    );
  }
}

// ElevatedButton( Botão que cria o popup
//                   child: Text(
//                     'Selecionar',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white
//                     ),
//                   ),
//                   onPressed: () => _dialogBuilder(context),
//                   style: ButtonStyle(
//                           backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(98, 0, 238, 30.0)),
//                           foregroundColor: MaterialStatePropertyAll(Colors.white),          
//                           ),
//                 );