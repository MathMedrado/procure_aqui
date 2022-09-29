import 'package:flutter/material.dart';
import 'package:procure_aqui/pages/UserFormPage.dart';
import 'package:procure_aqui/route_generator.dart';
import 'pages/HomePage.dart';
import 'pages/LoginPage.dart';
import 'pages/ForgetPasswordPage.dart';

void main() {
  runApp(const ProcureAqui());
}

class ProcureAqui extends StatelessWidget {
  const ProcureAqui ({super.key});

  static const home = '/';
  static const LoginPage = '/LoginPage';
  static const ForgetPassword = '/ForgetPassword';
  static const userForm = '/UserFormPage';




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      onGenerateRoute: routeGenerator.generateRoute,
    );
  }
}

