import 'package:flutter/material.dart';


ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white, // Set light theme scaffold background color
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF001F5F), // Set light theme AppBar color
    foregroundColor: Colors.white, // Set light theme AppBar text color
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black, // Set dark theme scaffold background color
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900], // Set dark theme AppBar color
    foregroundColor: Colors.white, // Set dark theme AppBar text color
  ),
);