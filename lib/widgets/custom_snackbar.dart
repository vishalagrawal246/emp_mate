import 'package:flutter/material.dart';

class CustomSnackbar {
  static showSnackBarSimple(String msg, BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            content: Text(
              msg,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            action: SnackBarAction(
              label: "DISMISS",
              onPressed: () {
                try {
                  ScaffoldMessenger.of(context).clearSnackBars();
                } catch (e) {
                  rethrow;
                }
              },
            )),
      );
  }
}
