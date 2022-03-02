import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    dividerColor: Colors.black12,
    fontFamily: 'Poppins',
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        elevation: 0.0,
        titleTextStyle: TextStyle(fontSize: 16.0, color: Colors.white)));
