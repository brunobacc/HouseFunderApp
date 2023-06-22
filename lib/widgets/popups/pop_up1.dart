import 'package:flutter/material.dart';

class PopUp1 {
  BuildContext context;
  PopUp1(this.context);

  static void popUpType1(
    BuildContext context,
    String title,
    String message,
  ) {
    var popup = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return popup;
      },
    );
  }
}
