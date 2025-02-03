import 'package:flutter/material.dart';

class Utils {
  static void showMessage(
    BuildContext context,
    String title,
    String message,
    String buttonText,
    Function onPressed, {
    bool isConfirmationDiaglog = false,
    String buttonText2 = "",
    Function? onPressed2,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
               // Navigator.of(context).pop();
                onPressed();
              },
              child: Text(buttonText),
            ),
            if (isConfirmationDiaglog)
              TextButton(
                onPressed: () {
                //  Navigator.of(context).pop();
                  if (onPressed2 != null) onPressed2();
                },
                child: Text(buttonText2),
              ),
          ],
        );
      },
    );
  }
}
