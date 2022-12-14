import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:procure_aqui/pages/UserFormPage.dart';
import 'package:procure_aqui/route_generator.dart';
import 'pages/HomePage.dart';
import 'pages/LoginPage.dart';
import 'pages/ForgetPasswordPage.dart';
import 'pages/UserProfile.dart';

void main() {
  runApp(const ProcureAqui());
}

class ProcureAqui extends StatelessWidget {
  const ProcureAqui ({super.key});

  static const home = '/';
  static const LoginPage = '/LoginPage';
  static const ForgetPassword = '/ForgetPassword';
  static const userForm = '/UserFormPage';
  static const userProfilePage = '/UserProfilePage';




  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: "/Start",
      onGenerateRoute: routeGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      title: 'Procure Aqui',
    );
  }
}

