import 'package:kalkukator/common/configs.dart';
import 'package:kalkukator/common/constans.dart';
import 'package:kalkukator/common/styles.dart';
import 'package:kalkukator/page/splash_page.dart';
import 'package:flutter/material.dart';

class Kalkulator extends StatelessWidget {
  const Kalkulator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kGAppName,
      theme: tdMain,
      localizationsDelegates: kLDelegates,
      supportedLocales: kLSupports,
      home: const SplashPage(),
    );
  }
}