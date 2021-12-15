import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showAlertScreen(BuildContext context, String title, String message) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {

        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(message),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK')),
          ],
        );
      });
}