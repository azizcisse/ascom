// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AOutlinedButtonTheme {
  AOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        elevation: 0, 
        foregroundColor: Colors.black, 
        side: BorderSide(color: Colors.blue), 
        textStyle: TextStyle(fontSize: 16, color: Colors.black,  fontWeight: FontWeight.bold),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20), 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );


  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        elevation: 0, 
        foregroundColor: Colors.white, 
        side: BorderSide(color: Colors.blue), 
        textStyle: TextStyle(fontSize: 16, color: Colors.white,  fontWeight: FontWeight.bold),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20), 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}
