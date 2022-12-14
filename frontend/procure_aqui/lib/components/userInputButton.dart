import 'package:flutter/material.dart';
import 'package:procure_aqui/models/user.dart';


class userInputButton extends StatelessWidget {
  const userInputButton(this.buttonColor, this.buttonText, this.func, {super.key});

  final Color? buttonColor;
  final String buttonText;
  final void Function() func;

  @override
  Widget build(BuildContext context) {
    return Container(
            width: 220,
            height: 45,
            margin: EdgeInsets.fromLTRB(20, 20, 0, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: ElevatedButton(
              child: Text(
                buttonText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(buttonColor),
              ),
              onPressed: func,
            ),
          );
  }
}