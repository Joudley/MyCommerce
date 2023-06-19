import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './done/api.dart';
import '../../main.dart';

class Konekte extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _KonekteState();
  }

}

class _KonekteState extends State<Konekte>{

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nonItilizate = TextEditingController();
  TextEditingController _modpas = TextEditingController();
  String _ere = "";
  bool _progresyon = false; // si dwe yon bagay ki dwe afiche pou montre progresyon nan operasyon konekte a

  @override
  Widget build(BuildContext context) {
    MyAppState state = context.watch<MyAppState>();
    TextStyle style = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    double sizeBoxHeight = 50;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Connecter",style: style,),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Connection",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: sizeBoxHeight,),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Entrer votre nom d'utlisateur"
                    ),
                    controller: _nonItilizate,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Answer required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: sizeBoxHeight,),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Entrer votre mot de passe"
                    ),
                    obscuringCharacter: "*",
                    obscureText: true,
                    controller: _modpas,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Answer required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: sizeBoxHeight,),
                  _progresyon ? CircularProgressIndicator() : Text(_ere,style: TextStyle(color: Colors.red,fontSize: 20),),
                  SizedBox(height: sizeBoxHeight,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.black,
                        minimumSize: Size(double.infinity, 40),
                        shape : ContinuousRectangleBorder(borderRadius: BorderRadius.circular(5.0))
                    ),
                    onPressed: () async{
                      setState(() {
                        _progresyon = true;
                      });
                      if(_formKey.currentState!.validate()) {
                        String username = _nonItilizate.text;
                        String password = _modpas.text;
                        Map<String, String> loginInfo = {
                          "username" : username,
                          "password" : password,
                        };
                        bool response = await APIService.konekte(loginInfo);
                        if(response){
                          dynamic user = await APIService.rekipereItilizate(username);
                          await state.konekte(user);
                          setState(() {
                            _ere = "";
                          });
                          _aleNanPajAkey();
                        }
                        else{
                          setState(() {
                            _ere = "Le nom d'utilisateur ou le mot de passe est incorrect";
                          });
                        }
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Les donnees entrees ne sont pas correctes")));
                      }
                      setState(() {
                        _progresyon = false;
                      });
                    },
                    child: Text("Se connecter"),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }

  void _aleNanPajAkey(){
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(
        builder: (ctx){ return Akey();}
      )
    );
  }
}