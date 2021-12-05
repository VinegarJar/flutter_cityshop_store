import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';

class CaterGoryPages extends StatefulWidget {
  CaterGoryPages({Key key}) : super(key: key);

  @override
  _CaterGoryPagesState createState() => _CaterGoryPagesState();
}

class _CaterGoryPagesState extends State<CaterGoryPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.homemainColor,
      appBar: AppBar(
        backgroundColor: ThemeColors.mainColor,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("借款"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Text(""),
      ),
    );
  }
}
