import 'package:flutter/material.dart';
import 'package:hmais_argamassa/view/splash.dart';


void main() {
  runApp(new MaterialApp(
    home: Splash(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.deepOrange, accentColor: Colors.white),
  ));
}
