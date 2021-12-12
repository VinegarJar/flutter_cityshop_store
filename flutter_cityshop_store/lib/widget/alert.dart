import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

   static modalButtomSheet({
     @required BuildContext context,
   }) async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("设置"),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("主页"),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text("信息"),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        });
  }


  
}
