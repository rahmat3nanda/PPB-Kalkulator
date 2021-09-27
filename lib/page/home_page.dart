import 'package:kalkukator/common/constans.dart';
import 'package:kalkukator/common/styles.dart';
import 'package:kalkukator/dialog/exit_dialog.dart';
import 'package:kalkukator/dialog/info_dialog.dart';
import 'package:kalkukator/model/app/singleton_model.dart';
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

  @override
  void initState() {
    super.initState();
    _model = SingletonModel.withContext(context);
    _helper = Helper();
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
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return SpinKitPulse(
              color: primaryColor,
              size: 64.0,
            );
          case ConnectionState.done:
            if (snapshot.hasData) {
              _data = snapshot.data as List<MenuModel>;

              return _data.isEmpty
                  ? const Center(child: Text("Tidak Ada Data"))
                  : _mainView();
            } else if (snapshot.hasError) {
              return Center(
                child: ReloadDataWidget(
                  error: "${snapshot.error}",
                  onReload: () => setState(() {
                    _future = _request.allMenu();
                  }),
                ),
              );
            }
        }
        return Container();
      },
    );
  }

  Widget _mainView() {
    TextStyle s = const TextStyle(fontSize: 12.0);
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      primary: true,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: _data.length,
      itemBuilder: (context, i) {
        MenuModel d = _data[i];
        return Card(
          color: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          elevation: 4.0,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ImageNetworkWidget(
                    url: d.foto!,
                    width: 64.0,
                    height: 64.0,
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(d.nama!),
                        Text(
                          d.kategori.nama!,
                          style: s,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          _helper.formatRupiah("${d.harga ?? 0}"),
                          style: s,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
            ),
            onTap: () => _helper.jumpToPage(
              context,
              page: MenuDetailPage(id: d.id!),
            ),
          ),
        );
      },
    );
  }
}
