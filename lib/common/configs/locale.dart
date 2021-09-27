import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const kLDelegates = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

const kLSupports = [
  Locale('en'),
  Locale('id'),
];

DateFormat kLFormat = DateFormat("dd-MMMM-yyyy");
