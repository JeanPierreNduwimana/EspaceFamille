import 'package:flutter/material.dart';

class SharedHelpers {
  SharedHelpers();

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showMessage(
      {required String message,
      required BuildContext buildContext,
      int? duration}) {
    return ScaffoldMessenger.of(buildContext).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: duration ?? 3),
      ),
    );
  }
}
