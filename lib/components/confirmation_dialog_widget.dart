import 'package:flutter/material.dart';

Future<void> showConfirmationDialog({
  required BuildContext context,
  required String question,
  required String cancelButtonText,
  required String confirmButtonText,
  required VoidCallback onCancel,
  required VoidCallback onConfirm,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(question),
        actions: <Widget>[
          TextButton(
            child: Text(cancelButtonText),
            onPressed: () {
              onCancel();
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: Text(confirmButtonText),
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}
