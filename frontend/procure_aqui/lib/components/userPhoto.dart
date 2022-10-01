import 'package:flutter/material.dart';

class userPhoto extends StatelessWidget {
  const userPhoto(this.name, {super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
        Container(
          margin: EdgeInsets.only(top: 40),
          width: 150,
          height: 150,
          child: Image.asset(
            'lib/assets/images/userIcon.png',
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 22,
              color: Colors.white
            ),
          ),
        )
      ]
    );
  }
}