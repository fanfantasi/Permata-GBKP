import 'package:anggota/service/constants.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    dividerColor: Colors.grey.withOpacity(0.6),
    fontFamily: 'Poppins',
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        titleTextStyle: TextStyle(fontSize: 16.0, color: Colors.white)));
