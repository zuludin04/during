import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get defaultTheme {
    return ThemeData(
      primaryColor: const Color(0xff373a36),
      primaryColorDark: const Color(0xff111410),
      primaryColorLight: const Color(0xff616460),
      accentColor: const Color(0xffffa400),
      fontFamily: 'NotoSans',
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xffffa400)),
        ),
      ),
    );
  }
}
