import 'package:flutter/material.dart';

class UserInformation extends StatelessWidget {
  const UserInformation(this.userdata, this.information, {super.key});

  final String? userdata;
  final String? information;

  @override
  Widget build(BuildContext context) {
    return Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text(
                  information!,
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xFF402424)
                  ),
                  ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  userdata!,
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
              )
            ],
          );
  }
}