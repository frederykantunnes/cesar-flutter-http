import 'package:flutter/material.dart';
import 'package:hmais_argamassa/controller/UserController.dart';
import 'package:hmais_argamassa/view/home.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var userController = UserController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          color: Colors.deepOrange,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("img/logo.png", width: size.width - 70,),
                SizedBox(height: 20,),
                SizedBox(
                  width: size.width - 70,
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: <Widget>[


                            SizedBox(height: 10,),
                            Container(
                                padding: EdgeInsets.only(left: 16),
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.person_pin),
                                    Expanded(
                                      child: TextFormField(
                                        cursorColor: Colors.black,
                                        controller: userController.textControllerCnpj,
                                        decoration: new InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding:
                                            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                            hintText: "CNPJ (99.999.999.0001/99)"),
                                      ),
                                    )
                                  ],
                                )
                            ),

                            SizedBox(height: 10,),
                            Container(
                                padding: EdgeInsets.only(left: 16),
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.lock),
                                    Expanded(
                                      child: TextFormField(
                                        obscureText: true,
                                        controller: userController.textControllerSenha,
                                        cursorColor: Colors.black,
                                        decoration: new InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding:
                                            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                            hintText: "Senha"),
                                      ),
                                    )
                                  ],
                                )
                            ),
                            SizedBox(height: 40,),
                            SizedBox(
                              height: 48,
                              width: size.width,
                              child: RaisedButton(
                                color: Colors.deepOrange,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child: Text("LOGIN", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),),
                                onPressed: (){
                                  userController.validarUsuario(context);
                                },
                              ),
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                      )
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
