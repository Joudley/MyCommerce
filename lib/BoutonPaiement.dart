import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'PaiementPage.dart';

class BoutonPeye extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyAppState appState = context.watch<MyAppState>();
    TextStyle appbarStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    return TextButton(
      onPressed: (){
        if(appState.siItilizateKonekte()){
            Navigator.push(context, MaterialPageRoute(
                builder: (ctx){ return PajPouPeye();}
            )
          );
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tu dois etre connecter pour payer")));
        }
      },
      child: Text("Payer", style: appbarStyle,),
    );
  }
}