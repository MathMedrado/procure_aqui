// import 'package:flutter/material.dart';

// class inputField extends StatelessWidget {
//   const inputField({ required this.inputText, required this.func, required this.userData, super.key});

//   final String inputText;
//   final Function(TextEditingController?) func;
//   final TextEditingController? userData;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: double.infinity,
//           margin: EdgeInsets.fromLTRB(33, 0, 0, 5),
//           child: Text(inputText)
//         ),
//         Container(
//           height: 50,
//           width: 350,
//           margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
//           child: TextField(
//             controller: userData,
//             onChanged: func(userData),
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(4)
//               )
//             ),
//           ),
//         )

//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';

class inputField extends StatelessWidget {
  const inputField({ required this.inputText, super.key});

  final String inputText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(33, 0, 0, 5),
          child: Text(inputText)
        ),
        Container(
          height: 50,
          width: 350,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4)
              )
            ),
          ),
        )

      ],
    );
  }
}