import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: Colors.transparent,

      // 🔥 Definir temas globais para textos
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Color(0xFFADADAD)),
        bodySmall: TextStyle(color: Colors.white70)
      ),

      // 🔥 Definir temas globais para o AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),


      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    );
  }
}
