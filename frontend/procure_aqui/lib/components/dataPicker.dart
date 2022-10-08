import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class dataPicker extends StatelessWidget {
  const dataPicker(this.date, this.func, {super.key});

  final DateTime? date;
  final Function(BuildContext) func;
  @override
  Widget build(BuildContext context) {
    return  Column(
            children: [
              Container(
                width: 150,
                margin: EdgeInsets.only(left: 28, bottom: 5),
                child: Text('data de nascimento*')
              ),
              Container(
                width: 160,
                height: 50,
                margin: EdgeInsets.only(left: 30),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(4))
                ),
                child:  Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        date == null? '                     ' : DateFormat('d/MM/y').format(date!)
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_month),
                      iconSize: 25,
                      alignment: Alignment.bottomRight,
                      onPressed: (){
                        func(context);
                      },
                    ),
                  ],
                )
              ),
            ],
          );
  }
}