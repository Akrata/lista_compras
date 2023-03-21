import 'package:flutter/material.dart';

class AppTheme {
  static Color greenLigth = Colors.green.shade100;
  static Color greenMedium = Colors.green.shade400;
  static Color greenHard = Colors.green.shade800;

  static final ThemeData lightTheme = ThemeData().copyWith(
    // useMaterial3: true,
    appBarTheme: AppBarTheme(
      color: greenLigth,
      elevation: 0,
      centerTitle: true,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: greenHard),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: greenLigth,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: greenLigth,
        shape: StadiumBorder(),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: TextStyle(
        color: greenHard,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: greenHard,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: greenHard,
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
        ),
      ),
      border: OutlineInputBorder(),
    ),
  );
}
