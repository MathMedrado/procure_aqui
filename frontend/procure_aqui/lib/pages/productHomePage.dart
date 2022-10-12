import 'package:flutter/material.dart';

class productHomePage extends StatefulWidget {
  const productHomePage({super.key});

  @override
  State<productHomePage> createState() => _productHomePageState();
}



class _productHomePageState extends State<productHomePage> {

  Widget _buildPopUpCard(){
    return Center(
      child: Card(
        elevation: 5,
        child: Container(
          width: 368,
          height: 265,
          color: Colors.green,
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
              )
            ]
          ),
        ),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildPopUpCard();
  }
}