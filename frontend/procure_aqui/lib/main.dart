import 'package:flutter/material.dart';
import 'package:procure_aqui/components/UserFormPage.dart';
import 'components/HomePage.dart';
import 'components/LoginPage.dart';
import 'components/ForgetPassword.dart';

void main() {
  runApp(const ProcureAqui());
}

class ProcureAqui extends StatelessWidget {
  const ProcureAqui ({super.key});

  static const home = '/';
  static const LoginPage = 'LoginPage';
  static const ForgetPassword = 'ForgetPassword';
  static const userForm = 'UserFormPage';




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        home:(context) => HomePage(),
        LoginPage:(context) => Login(),
        ForgetPassword:(context) => ForgetPasswordPage(),
        userForm: (context)=> UserFormPage()
      },
    );
  }
}

