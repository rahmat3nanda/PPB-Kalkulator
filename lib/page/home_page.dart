import 'dart:convert';

import 'package:kalkukator/common/constans.dart';
import 'package:kalkukator/common/styles.dart';
import 'package:kalkukator/data/sp_data.dart';
import 'package:kalkukator/dialog/delete_dialog.dart';
import 'package:kalkukator/dialog/exit_dialog.dart';
import 'package:kalkukator/dialog/info_dialog.dart';
import 'package:kalkukator/model/app/singleton_model.dart';
import 'package:kalkukator/model/history_model.dart';
import 'package:kalkukator/tool/helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SingletonModel _model;
  late Helper _helper;

  late GlobalKey<FormState> _formKey;
  late TextEditingController _cAngka1;
  int? _operasi;
  late TextEditingController _cAngka2;
  late TextEditingController _cHasil;

  @override
  void initState() {
    super.initState();
    _model = SingletonModel.withContext(context);
    _helper = Helper();
    _formKey = GlobalKey<FormState>();
    _cAngka1 = TextEditingController();
    _cAngka2 = TextEditingController();
    _cHasil = TextEditingController();
  }

  String? _validator(String? s) {
    return s!.isEmpty
        ? "Kolom Wajib Diisi!"
        : !_helper.isNumeric(s)
            ? "Format Angka Tidak Valid!"
            : null;
  }

  void _reset() {
    setState(() {
      _operasi = null;
      _cAngka1.text = "";
      _cAngka2.text = "";
      _cHasil.text = "";
    });
  }

  void _hitung() {
    if (_formKey.currentState!.validate()) {
      if (_operasi == null) {
        _helper.showToast("Harap Pilih Operasi!");
      } else {
        double a1 = double.parse(_cAngka1.text);
        double a2 = double.parse(_cAngka2.text);
        late String simbol;
        late double hasil;
        switch (_operasi) {
          case 0:
            hasil = a1 + a2;
            simbol = "+";
            break;
          case 1:
            hasil = a1 - a2;
            simbol = "-";
            break;
          case 2:
            hasil = a1 * a2;
            simbol = "*";
            break;
          case 3:
            hasil = a1 / a2;
            simbol = "/";
            break;
        }
        setState(() {
          _cHasil.text = "$hasil";
          _model.history.add(HistoryModel(
            bil1: a1,
            bil2: a2,
            operasi: simbol,
            hasil: hasil,
          ));
        });
        _saveData();
      }
    }
  }

  void _onItemLongPress(int i) async {
    bool hapus = await openDeleteDialog(context) ?? false;
    if (hapus) {
      setState(() {
        _model.history.removeAt(i);
      });
    }
    _saveData();
  }

  void _saveData(){
    SPData().saveToSP(
      kDHistory,
      SharedDataType.string,
      jsonEncode(_model.history),
    );
  }

  Future<bool> _onWillPop() async {
    bool exit = await openExitDialog(context) ?? false;
    return Future.value(exit);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(kGAppName),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () => openInfoDialog(context),
            )
          ],
        ),
        body: _buildBody(),
      ),
      onWillPop: _onWillPop,
    );
  }

  Widget _buildBody() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _cAngka1,
                keyboardType: TextInputType.number,
                validator: _validator,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'Angka Pertama',
                  labelText: 'Angka Pertama',
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _radioText(title: "Tambah", value: 0),
                  _radioText(title: "Kurang", value: 1),
                ],
              ),
              Row(
                children: [
                  _radioText(title: "Kali", value: 2),
                  _radioText(title: "Bagi", value: 3),
                ],
              ),
              TextFormField(
                controller: _cAngka2,
                keyboardType: TextInputType.number,
                validator: _validator,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: 'Angka Kedua',
                  labelText: 'Angka Kedua',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          child: const Text("Reset"),
          color: primaryColor,
          textColor: Colors.white,
          onPressed: _reset,
        ),
        MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          child: const Text("Hitung"),
          color: primaryColor,
          textColor: Colors.white,
          onPressed: _hitung,
        ),
        if (_cHasil.text.isNotEmpty) const SizedBox(height: 16.0),
        if (_cHasil.text.isNotEmpty)
          TextFormField(
            controller: _cHasil,
            enabled: false,
            decoration: const InputDecoration(
              labelText: 'Hasil',
            ),
          ),
        ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: _model.history.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            HistoryModel h = _model.history[i];
            return InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    Text("${h.bil1}"),
                    const SizedBox(width: 8.0),
                    Text("${h.operasi}"),
                    const SizedBox(width: 8.0),
                    Text("${h.bil2}"),
                    const SizedBox(width: 8.0),
                    const Text("="),
                    Expanded(child: Container()),
                    Text(
                      "${h.hasil}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              onLongPress: ()=> _onItemLongPress(i),
            );
          },
        ),
      ],
    );
  }

  Widget _radioText({required String title, required int value}) {
    return Expanded(
      child: Row(
        children: [
          Radio<int>(
            value: value,
            groupValue: _operasi,
            onChanged: (s) => setState(() {
              _operasi = s;
            }),
          ),
          Text(title),
        ],
      ),
    );
  }
}
