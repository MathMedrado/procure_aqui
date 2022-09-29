import 'package:flutter/material.dart';

class smallPurpleButton extends StatelessWidget {
  const smallPurpleButton( this.text, {super.key});

  final String? text;
  @override
  Widget build(BuildContext context) {
    return Container(
                  width: 148,
                  height: 40,
                  margin: EdgeInsets.only(left: 30, top: 20),
                  child: 
                    ElevatedButton(
                      child:  Text(
                        text!,
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                      onPressed: (){},
                      style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(98, 0, 238, 30.0)),
                              foregroundColor: MaterialStatePropertyAll(Colors.white),          
                              ),
                    ),
                );
  }
}