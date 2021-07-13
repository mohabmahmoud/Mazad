import 'package:flutter/material.dart';
import '../Constants/color.dart';
class appTheme{
  static ThemeData apptheme=ThemeData(
    primaryColor: HexColor('28333f'),
    cursorColor: HexColor('32c9c7'),
    accentColor:Colors.black,
    appBarTheme: AppBarTheme(
      elevation: 0.1,color: Colors.white,textTheme: TextTheme(title: TextStyle(fontSize: 20,fontFamily: 'mohab',color: Colors.black,fontWeight: FontWeight.w900)),
      iconTheme: IconThemeData(
        color:HexColor('28333f'),
      ),),

  );
}