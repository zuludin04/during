import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get defaultTheme {
    return ThemeData(
      primaryColor: Color(0xff373a36),
      primaryColorDark: Color(0xff111410),
      primaryColorLight: Color(0xff616460),
      accentColor: Color(0xffffa400),
      fontFamily: 'NotoSans',
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xffffa400)),
        )
      ),
    );
  }
}