import 'package:flutter/material.dart';
import 'package:procure_aqui/pages/HomePage.dart';
import 'package:procure_aqui/pages/LoginPage.dart';
import 'package:procure_aqui/pages/UserProfile.dart';
import 'package:procure_aqui/models/user.dart';
import 'package:procure_aqui/pages/listOfProducts.dart';
import 'package:procure_aqui/pages/newUserFormPage.dart';
import 'package:procure_aqui/components/appBarSearchFeature.dart';
import 'package:procure_aqui/components/sideBarMenu.dart';
import 'package:procure_aqui/pages/productHomePage.dart';
import 'package:procure_aqui/pages/tutorialPage.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AppHome extends StatefulWidget  {
  const AppHome({super.key});
   
  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {

  int currentIndex = 0;

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
  Future<void> _dialogBuilder(BuildContext context){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return _buildPopUpCard();
        }
    );
  }


  Widget _buildPopUpCard(){
    return Center(
      child: Card(
        child:  Container(
          padding: EdgeInsets.all(20),
          width: 375,
          height: 170,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xFF3700B3),
          ),
          child: Column(
            children: [
              Container(
                width: 320,
                child: Text(
                  'Esta função só está acessivel para usuários logados no sistema',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30, top: 35),
                    width: 110,
                    height: 27,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.blue)
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                      ),
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, '/LoginPage');
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 60, top: 35),
                    width: 110,
                    height: 27,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.blue
                    ),

                    child: ElevatedButton(
                        child: Text(
                          'Cadastro',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, '/UserFormPage');
                        }
                    ),

                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }



  final screens = [
    productHomePage(),
    tutorialPage(),
    listOfProducts(),
    UserProfilePage(user: User(id: 1, username: 'matheus', email: 'matheus-13-@hotmail.com', birthDate:DateTime.now(),  city: 'Rialma', sex: 'Masculino', password: '1234567891', state: 'Goiás' ))
  ];

  final appBar = [
    AppBarSearchFeature(),
    AppBarSearchFeature(),
    AppBarSearchFeature(),
    AppBar(title: Text('Perfil do Usuario'), backgroundColor: Color(0xFF3700B3)),

  ];

  // Widget homeAppBar(){
  //   return AppBar(
  //        title: Text(appBar[currentIndex]),
  //        backgroundColor: Color(0xFF3700B3),
         
  //      );
  // }

  // final  List<Map<String,Widget>> screensWithAppBar = [
  //   {
  //     'appBarData' : 'Perfil do usuário',
  //     'widget' :     UserProfilePage(user: User(id: 1, username: 'matheus', email: 'matheus-13-@hotmail.com', birthDate:DateTime.now(),  city: 'Rialma', sex: 'Masculino', password: '1234567891', state: 'Goiás' )),
  //   },
  //   {
  //     'appBarData' : 'Perfil do usuário',
  //     'widget' : newUserFormPage(),
  //   },
  //   {
  //     'appBarData' :' Perfil do usuário',
  //     'widget' : newUserFormPage(),
  //   },
  //   {
  //     'appBarData' : 'Perfil do usuário',
  //     'widget' : UserProfilePage(user: User(id: 1, username: 'matheus', email: 'matheus-13-@hotmail.com', birthDate:DateTime.now(),  city: 'Rialma', sex: 'Masculino', password: '1234567891', state: 'Goiás' )),
  //   },
  // ];


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // appBar: AppBar(
      //    title: Text(appBar[currentIndex]),
      //    backgroundColor: Color(0xFF3700B3),
      //  ),
      drawer: SideBarMenu(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: appBar[currentIndex]
      ),
       body: screens[currentIndex],
       bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            if(index == 1||  index == 2 || index == 3){
              verifyToken().then((value) {
                if(value ==false ){
                  print(value);
                  _dialogBuilder(context);
                }else {
                  setState(() { currentIndex = index;});
                }
              });
            }else{
              setState(() { currentIndex = index;});
            }
          },
          items:const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_a_photo, 
                ),
                label: 'Add Product',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart, 
                ),
                label: 'list of products',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person, 
                ),
                label: 'list of products',
              )
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF3700B3),
          selectedItemColor: Colors.blue,
          selectedLabelStyle: TextStyle(color: Colors.blue),
          unselectedItemColor: Colors.white,
          iconSize: 25,
          showUnselectedLabels: false,
          showSelectedLabels: true,
        ),
    );
  }
}