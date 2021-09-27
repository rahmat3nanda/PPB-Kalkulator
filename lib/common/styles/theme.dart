import 'package:kalkukator/common/styles/color.dart';
import 'package:flutter/material.dart';

ThemeData tdMain = ThemeData(
  primaryColor: primaryColor,
  primaryColorDark: primaryColor,
  primarySwatch: Colors.blue,
  inputDecorationTheme: InputDecorationTheme(
    hoverColor: primaryColor,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor),
    ),
  ),
);
