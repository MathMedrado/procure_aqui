import 'package:flutter/material.dart';
import 'package:procure_aqui/components/userPhoto.dart';
import 'package:procure_aqui/components/userInformation.dart';
import 'package:procure_aqui/components/userInformationInRow.dart';
import 'package:procure_aqui/components/userInputButton.dart';
import 'package:procure_aqui/models/user.dart';
import 'package:intl/intl.dart';
import 'package:procure_aqui/pages/appHome.dart';



class UserProfilePage extends StatelessWidget {
  const UserProfilePage  ( { required this.user , super.key});

  final User user;
  // final String? username = user.getEmail;
  final String emailInformation = 'Email: ';
  final String email = 'Arianagrande@gmail.com';
  final String dateInformation = 'Data de nascimento: ';
  final String date = '23/06/2001';
  final String sexInformation = 'Sexo: ';
  final String sex = 'feminino';
  final String cityInformation = 'Cidade: ';
  final String city = 'Faina';
  final String stateInformation = 'Estado: ';
  final String state = 'Goiás';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Perfil do usuário"),
//         backgroundColor: Color(0xFF3700B3),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: double.infinity,
//               height: 270,
//               color: Color(0xFF3700B3),
//               child: Column(
//                 children: [
//                   userPhoto(user.getUsername)   
//                 ],
//               ),
//             ),
//             UserInformation(user.getEmail, emailInformation),
//             UserInformation(DateFormat('d/MM/y').format(user.getBirthDate as DateTime), dateInformation),
//             UserInformation(user.getSex, sexInformation),
//             Row(
//               children: [
//                 userInformationInRow(cityInformation, user.getCity),
//                 userInformationInRow(stateInformation, user.getState),
//               ],
//             ),
//             userInputButton(Color(0xFF7B61FF), 'Atualizar Dados'),
//             userInputButton(Color(0xFFadd8e6), 'Sair da conta'),
//             userInputButton(Color(0xFFE70101), 'Exclusão da conta'),
            
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomNavigationBar()
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 270,
              color: Color(0xFF3700B3),
              child: Column(
                children: [
                  userPhoto(user.getUsername)   
                ],
              ),
            ),
            UserInformation(user.getEmail, emailInformation),
            UserInformation(DateFormat('d/MM/y').format(user.getBirthDate as DateTime), dateInformation),
            UserInformation(user.getSex, sexInformation),
            Row(
              children: [
                userInformationInRow(cityInformation, user.getCity),
                userInformationInRow(stateInformation, user.getState),
              ],
            ),
            userInputButton(Color(0xFF7B61FF), 'Atualizar Dados', (){}),
            userInputButton(Color(0xFFadd8e6), 'Sair da conta', (){}),
            userInputButton(Color(0xFFE70101), 'Exclusão da conta', (){
              Navigator.of(context).pushNamed('/UserProfileExclusion', arguments:  user);
            }),
            
          ],
        ),
      );
  }
}