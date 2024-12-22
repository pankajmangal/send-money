import 'package:flutter/material.dart';

class AppUtils {

  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  static void hideKeyboardWithoutContext() {
    FocusManager focusManager = FocusManager.instance;
    focusManager.primaryFocus?.unfocus();
  }

  // Custom snack bar...
  static void customSnackBar(title, msg) {
    SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), Text(msg)],
        ),
        backgroundColor: Colors.black87);
  }
}