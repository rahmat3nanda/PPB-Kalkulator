import 'dart:convert';

import 'package:kalkukator/common/constans.dart';
import 'package:kalkukator/common/styles.dart';
import 'package:kalkukator/data/sp_data.dart';
import 'package:kalkukator/model/app/singleton_model.dart';
import 'package:kalkukator/model/history_model.dart';
import 'package:kalkukator/page/home_page.dart';
import 'package:kalkukator/tool/helper.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SingletonModel _model;
  late Helper _helper;

  @override
  void initState() {
    super.initState();
    _model = SingletonModel.withContext(context);
    _helper = Helper();
    _checkData();
  }

  void _checkData() async {
    String? history =
        await SPData().loadFromSP(kDHistory, SharedDataType.string);
    if (history == null) {
      _model.history = [];
    } else {
      _model.history = List<HistoryModel>.from(
        jsonDecode(history).map((x) => HistoryModel.fromJson(x)),
      );
    }

    await Future.delayed(const Duration(seconds: 2));
    _helper.moveToPage(context, page: const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            kGAppName,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            ),
          ),
        ),
      ),
    );
  }
}
