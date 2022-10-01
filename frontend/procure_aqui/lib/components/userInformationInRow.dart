import 'package:flutter/material.dart';

class userInformationInRow extends StatelessWidget {
  const userInformationInRow( this.information, this.userdata, {super.key});

  final String information;
  final String userdata;

  @override
  Widget build(BuildContext context) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 25, 0),
                child: Text(
                  information,
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xFF402424)
                  ),
                  ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 25, 0),
                child: Text(
                  userdata,
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
              ),
            ],
          );
  }
}