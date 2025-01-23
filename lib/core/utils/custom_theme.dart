import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTheme {
  static ThemeData get defaultTheme {
    return ThemeData(
      colorScheme: const ColorScheme(
        primary: Colors.white,
        primaryContainer: Color(0xffcccccc),
        secondary: Colors.blue,
        secondaryContainer: Color(0xff0069c0),
        surface: Colors.white,
        error: Colors.redAccent,
        onPrimary: Color(0xff252526),
        onSecondary: Colors.black,
        onSurface: Colors.black,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      fontFamily: 'PlusJakarta',
      iconTheme: const IconThemeData(color: Colors.black),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
        ),
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.black, fontSize: 14),
        bodySmall: TextStyle(color: Colors.black45, fontSize: 14),
        titleMedium: TextStyle(color: Colors.black87, fontSize: 14),
      ),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: const ColorScheme(
        primary: Color(0xff252526),
        primaryContainer: Colors.black,
        secondary: Color(0xffffa400),
        secondaryContainer: Color(0xffc67500),
        surface: Color(0xff252526),
        error: Colors.redAccent,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onError: Colors.white,
        brightness: Brightness.dark,
      ),
      fontFamily: 'PlusJakarta',
      iconTheme: const IconThemeData(color: Colors.white),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all<Color>(const Color(0xffffa400)),
        ),
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white, fontSize: 14),
        bodySmall: TextStyle(color: Colors.white54, fontSize: 14),
        titleMedium: TextStyle(color: Colors.white70, fontSize: 14),
      ),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(0xff252526),
          statusBarIconBrightness: Brightness.light,
        ),
      ),
    );
  }
}
