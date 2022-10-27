
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:procure_aqui/main.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? barCode;

  Future <void> _startScan() async {
    String barcodeScanRes; 
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#ff6666", 'Click Me', false, ScanMode.BARCODE);
      print('Funcionou ${barCode}');
    } on PlatformException {
      barcodeScanRes = 'Fail';
      print('não funcionou');

    }
    setState(() {
      barCode = barcodeScanRes;
      print(barCode);
    });

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xFF6200EE),
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(50, 100, 50, 50),
                child: Image.asset('lib/assets/images/logo2.png')
              ),
              Container(
                margin: EdgeInsets.all(50),
                child: Text("Seja bem vindo ao aplicativo Procure Aqui, o seu app de ofertas e comparação de preços de supermercados da sua região ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
                ),
                )
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                width: 220,
                height: 50,
                child: 
                  ElevatedButton(
                    child: Text('Entrar'),
                    onPressed: (){
                      Navigator.of(context).pushNamed(ProcureAqui.LoginPage);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      foregroundColor: MaterialStatePropertyAll(Colors.black)
                    ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                width: 220,
                height: 50,
                child: 
                  ElevatedButton(
                    child: Text("Cadastrar-se"),
                    onPressed: (){
                      Navigator.of(context).pushNamed(ProcureAqui.userForm);// olhar o push replacement
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      foregroundColor: MaterialStatePropertyAll(Colors.black)
                    ),
                  ) 
              ),
              TextButton(
                onPressed: (){
                  _startScan();
                },
                child: Text(
                  'Entrar sem cadastro',
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}