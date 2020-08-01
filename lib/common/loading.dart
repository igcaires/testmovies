import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

ProgressDialog pr;

class Loading {
  final BuildContext context;
  Loading(this.context);

  Future<void> openLoading({String msg = "Loading..."}) async {
    pr = ProgressDialog(context, type: ProgressDialogType.Normal);

    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: msg);

    await pr.show();
  }

  Future<void> hideLoading() async {
    await pr.hide();
  }
}
