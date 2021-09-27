import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExitDialog extends StatefulWidget {
  const ExitDialog({Key? key}) : super(key: key);

  @override
  _ExitDialogState createState() => _ExitDialogState();
}

class _ExitDialogState extends State<ExitDialog> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("Apakah anda yakin ingin keluar?"),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text("Ya"),
          onPressed: () => Navigator.pop(context, true),
        ),
        CupertinoDialogAction(
          child: const Text("Tidak"),
          onPressed: () => Navigator.pop(context, false),
        ),
      ],
    );
  }
}

Future openExitDialog(BuildContext context) {
  return showGeneralDialog(
    barrierLabel: "Exit Dialog ",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    context: context,
    pageBuilder: (context, anim1, anim2) => const ExitDialog(),
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (context, anim1, anim2, child) {
      return Transform.scale(
        scale: anim1.value,
        child: child,
      );
    },
  );
}
