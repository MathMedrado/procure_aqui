import 'package:flutter/material.dart';
import 'package:procure_aqui/pages/ForgetPasswordPage.dart';
import 'package:procure_aqui/pages/HomePage.dart';
import 'package:procure_aqui/pages/LoginPage.dart';
import 'package:procure_aqui/pages/UserFormPage.dart';
import 'package:procure_aqui/pages/UserProfile.dart';
import 'main.dart';

class routeGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage() );
      case '/LoginPage':
        return MaterialPageRoute(builder: (_) => Login() );
      case '/ForgetPassword':
        return MaterialPageRoute(builder: (_) => ForgetPasswordPage() );
      case '/UserFormPage':
        return MaterialPageRoute(builder: (_) => UserFormPage() );
      case '/UserProfilePage':
        return MaterialPageRoute(builder: (_) => UserProfilePage() );
      default:
        return _errorRoute();
    }
  }

  static  Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Text('Error'),
      );
    });
  }
}