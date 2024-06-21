import 'package:flutter/material.dart';

/// Defines the theme data for the application.
ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Poppins',
    appBarTheme: appBarTheme(),
  );
}

/// Defines the AppBar theme for the application.
AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.amber,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0XFF8B8B8B)),
    titleTextStyle: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
  );
}
