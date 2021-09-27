import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatefulWidget {
  const DeleteDialog({Key? key}) : super(key: key);

  @override
  _DeleteDialogState createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("Apakah anda yakin ingin menghapus history ini?"),
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

Future openDeleteDialog(BuildContext context) {
  return showGeneralDialog(
    barrierLabel: "Delete Dialog ",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    context: context,
    pageBuilder: (context, anim1, anim2) => const DeleteDialog(),
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (context, anim1, anim2, child) {
      return Transform.scale(
        scale: anim1.value,
        child: child,
      );
    },
  );
}
