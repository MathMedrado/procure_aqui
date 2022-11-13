
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> verifyToken() async {
  //vai conferir se temos um token dentro do aplicativo
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  if(sharedPreference.getString('token') != null){
    return true;
  }
  else{
    return false;
  }
}
