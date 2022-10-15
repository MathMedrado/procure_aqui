import 'package:flutter/material.dart';
import 'package:procure_aqui/pages/ForgetPasswordPage.dart';
import 'package:procure_aqui/pages/HomePage.dart';
import 'package:procure_aqui/pages/LoginPage.dart';
import 'package:procure_aqui/pages/UserFormPage.dart';
import 'package:procure_aqui/pages/UserProfile.dart';
import 'package:procure_aqui/pages/UserProfileExclusion.dart';
import 'package:procure_aqui/pages/newUserFormPage.dart';
import 'package:procure_aqui/pages/userEditProfile.dart';
import 'package:procure_aqui/pages/appHome.dart';
import 'package:procure_aqui/pages/userEditProfile.dart';
import 'models/user.dart';

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
        if(args is User){
          return MaterialPageRoute(
            builder: (_) => UserProfilePage(user: args)
          );
        }
        return _errorRoute();
      case '/AppHome':
        return MaterialPageRoute(builder: (_) => AppHome() );
      case '/UserProfileExclusion':
        if (args is User){
          return  MaterialPageRoute(
              builder: (_) => UserProfileExclusion(user: args)
            );
        }
        return _errorRoute();
      case '/UserEditProfile':
        return MaterialPageRoute( builder: (_) => UserEditProfile());
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