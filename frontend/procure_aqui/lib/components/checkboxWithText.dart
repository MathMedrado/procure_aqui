import 'package:flutter/material.dart';

class checkboxWithText extends StatelessWidget {
  const checkboxWithText(this.func, this.text, this.checkState, {super.key});

  final void Function(bool?) func;
  final String text;
  final bool? checkState;

  @override
  Widget build(BuildContext context) {
    return Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Checkbox(
                    value: checkState, 
                    onChanged: (checkStage){
                      func(checkState);
                    }
                  ),
                ),
                Text(
                  'Li e concordo com os termos de uso',
                  style: TextStyle(
                    fontSize: 12
                  ),
                )
              ]
    );
  }
}