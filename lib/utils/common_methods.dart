import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void appPrint(dynamic log) {
  if (kDebugMode) {
    print(log);
  }
}

void showAlertDialog(
    {required BuildContext context,
    required String title,
    String? content,
    required void Function() okCallBack,
    void Function()? cancelCallBack,
    String okButtonTitle = 'Ok',
    String cancelButtonTitle = 'Cancel'}) {
  Widget cancelButton =
      TextButton(child: Text(cancelButtonTitle), onPressed: cancelCallBack);
  Widget continueButton =
      TextButton(child: Text(okButtonTitle), onPressed: okCallBack);

  AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content ?? ''),
      actions: cancelCallBack != null
          ? [cancelButton, continueButton]
          : [continueButton]);

  showDialog(context: context, builder: (BuildContext context) => alert);
}

void showSuccess(String message, BuildContext context,
    {bool isUpperCase = true, Color backgroundColor = Colors.green}) {
  final SnackBar snackBar = SnackBar(
    backgroundColor: backgroundColor,
    duration: const Duration(seconds: 3),
    content: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            isUpperCase ? message.toUpperCase() : message,
            style: TextStyle(
                fontFamily: 'Roboto', color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showError(String message, BuildContext context,
    {bool isUpperCase = true, Color backgroundColor = Colors.red}) {
  final SnackBar snackBar = SnackBar(
    backgroundColor: backgroundColor,
    duration: const Duration(seconds: 3),
    content: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            isUpperCase ? message.toUpperCase() : message,
            style: TextStyle(
                fontFamily: 'Roboto', color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
