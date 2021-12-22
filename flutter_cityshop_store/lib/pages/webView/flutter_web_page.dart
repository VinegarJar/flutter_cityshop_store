
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/loding.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class FlutterWebPage extends StatefulWidget {
  final String resultUrl;
  final String title;
  FlutterWebPage({Key key, @required this.resultUrl, @required this.title})
      : super(key: key);

  @override
  _FlutterWebPageState createState() => _FlutterWebPageState();
}

class _FlutterWebPageState extends State<FlutterWebPage> {



  @override
  Widget build(BuildContext context) {
    return (
      WebviewScaffold(
        mediaPlaybackRequiresUserGesture: true,
        url: widget.resultUrl,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: ThemeColors.titlesColor),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            "产品详情",
            style: TextStyle(
                color: ThemeColors.titlesColor,
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtil().setSp(38)),
          ),
          centerTitle: true,
          backgroundColor: ThemeColors.homemainColor, //标题居中显示
        ),
        initialChild: Container(
          color: Colors.white,
          child: Center(child: LoadingWidget()),
        ))
    );
  }

}
