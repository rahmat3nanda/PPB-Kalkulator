import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kalkukator/common/constans.dart';

class InfoDialog extends StatefulWidget {
  const InfoDialog({Key? key}) : super(key: key);

  @override
  _InfoDialogState createState() => _InfoDialogState();
}

class _InfoDialogState extends State<InfoDialog> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("Informasi"),
      content: const Text("Dibuat Oleh : $kSNama - $kSNim"),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text("Tutup"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

Future openInfoDialog(BuildContext context) {
  return showGeneralDialog(
    barrierLabel: "Info Dialog ",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    context: context,
    pageBuilder: (context, anim1, anim2) => const InfoDialog(),
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (context, anim1, anim2, child) {
      return Transform.scale(
        scale: anim1.value,
        child: child,
      );
    },
  );
}
