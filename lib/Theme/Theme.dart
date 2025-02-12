// ignore_for_file: file_names

import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade900,
    primary: Colors.grey,
    secondary: Colors.grey.shade100,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.white,
    primary: Colors.grey.shade600,
    secondary: Colors.grey.shade900,
  ),
);
