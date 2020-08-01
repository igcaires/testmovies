import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType {
  error,
  alert,
  success,
}

_toast(String msg, ToastType type) async {
  return await Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    backgroundColor: (type == ToastType.error)
        ? Colors.red
        : (type == ToastType.alert)
            ? Colors.orange
            : (type == ToastType.success) ? Colors.greenAccent : Colors.red,
    textColor: Colors.white,
    fontSize: 18.0,
  );
}

showError(String e) {
  _toast(e, ToastType.error);
}
