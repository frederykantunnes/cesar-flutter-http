import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hmais_argamassa/controller/UserController.dart';
import 'package:hmais_argamassa/view/home.dart';
import 'package:hmais_argamassa/view/login.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    var userController = UserController();
    userController.isLogado(context).then((value){
      Future.delayed(Duration(milliseconds: 1000), (){
        if(value){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard()));
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
        }
      });
    });
    return Scaffold(
      body: Container(
        color: Colors.deepOrange,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("img/logo.png", width: MediaQuery.of(context).size.width/3*2,),
              SizedBox(height: 30,),
              CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
