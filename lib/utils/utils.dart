import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class Utils {
  static toastMessage(String message) {
    // we have given this method static keyword because we are using it globally
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      // fontSize: 24.0,
      // toastLength: Toast.LENGTH_LONG
    );
  }

  static void flushBarErrorMessgae(String message, BuildContext context) {
    showFlushbar(
      context: (context),
      flushbar: Flushbar(
        message: message,
        backgroundColor: Colors.redAccent,
        messageColor: Colors.black,
        title: "Error",
        duration: const Duration(seconds: 5),
      )..show(context),
    );
  }
}
