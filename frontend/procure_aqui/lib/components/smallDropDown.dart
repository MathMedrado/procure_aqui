import 'package:flutter/material.dart';

class smallDropDown extends StatelessWidget {
  const smallDropDown ( this.sexVar,this.func, {super.key});

  final String? sexVar;
  final Function(String?) func;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 150,
          margin: EdgeInsets.only(left: 28, bottom: 5),
          child: Text('Sexo*')
        ),
        Container(
          width: 160,
          margin: EdgeInsets.only(left: 30),
          child: DropdownButtonFormField(items: const [
            DropdownMenuItem(child: Text('Masculino'),value: "masculine"),
            DropdownMenuItem(child: Text('Feminino'),value: "feminine"),
          ],
          // value: _sexDropDownValue,
          // onChanged: sexDropDownHandler,
          validator: (value) => value == null ? 'Campo obrigatório' : null ,
          value: sexVar,
          onChanged: func,
          iconSize: 30,
          isExpanded: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.only(bottom: 5, left: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey
                )
            )
          ),
          ),
        ),
      ],
    );
  }
}