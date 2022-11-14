import 'package:flutter/material.dart';
import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';



class AppBarSearchFeature extends StatefulWidget {
  const AppBarSearchFeature({super.key});

  @override
  State<AppBarSearchFeature> createState() => _AppBarSearchFeatureState();
}

class _AppBarSearchFeatureState extends State<AppBarSearchFeature> {

  final String title = '';
  final searchText = ValueNotifier<String>('');
  
  @override
  Widget build(BuildContext context) {
    return AppBarWithSearchSwitch(
      fieldHintText: 'Buscar Produto',
      clearSearchIcon: Icons.backspace_outlined,

      backgroundColor:  Color(0xFF3700B3),
      onChanged: (text){
        searchText.value = text;
      },
      onSubmitted: (text) {
         searchText.value = text;
         Navigator.pushNamed(context, '/searchProduct', arguments: searchText.value);

      },
      appBarBuilder: (context) {
          return AppBar(
            // automaticallyImplyLeading: false, Onde quiser retirar o botão da navBar Clica aqui
            backgroundColor: Color(0xFF3700B3),
            title: Text(
                title,
                style: TextStyle(
                  fontSize: 16
                ),
              ),
            actions:  [
              AppBarSearchButton(),
              // or
              // IconButton(onPressed: AppBarWithSearchSwitch.of(context)?startSearch, icon: Icon(Icons.search)),
            ],
          );
        },
    );
  }
}