import 'package:flutter/cupertino.dart';

class Alert {
  static showAlert({
    @required BuildContext widgetContext,
    @required String title,
    @required String confirm,
    @required String cancel,
    String content = "",
    @required Function() onPressed,
  }) {
    showCupertinoDialog(
      context: widgetContext,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              child: Text(cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(confirm),
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop();
                onPressed();
              },
            ),
          ],
        );
      },
    );
  }
}
