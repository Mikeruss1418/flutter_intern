import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light()
);
ThemeData darkmode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(onSecondary: Colors.white)
);
