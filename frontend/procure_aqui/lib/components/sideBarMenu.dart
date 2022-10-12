import 'package:flutter/material.dart';

class SideBarMenu extends StatelessWidget {
  const SideBarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color:  Colors.deepPurple,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 100,
              child:  DrawerHeader(
                margin: EdgeInsets.all(0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: (){
                        Navigator.pop(context);

                      }
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Categorias',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title:  Text(
                'Hortifruti',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title:  Text(
                'Limpeza',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title:  Text(
                'Açougue',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title:  Text(
                'Bebidas',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title:  Text(
                'Produtos gerais',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}