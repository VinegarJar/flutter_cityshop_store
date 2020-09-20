import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/widget/appbar.dart';


class SplashScreenPage extends StatefulWidget {
  SplashScreenPage({Key key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(title: "豆瓣千城小店", canBack: false).build(context),
        body: Container(
          child: Center(
            child: Text(
              "豆瓣千城启动页",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28),
            ),
          ),
        ));
  }
}
