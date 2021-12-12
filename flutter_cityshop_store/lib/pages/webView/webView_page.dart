
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/loding.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print("-----------------" + message.message);
      }),
].toSet();

class WebViewUrlPage extends StatelessWidget {
  final String url;
  final String title;
  final bool isHtml;

  const WebViewUrlPage({
    Key key,
    @required this.url,
    @required this.title, 
    @required this.isHtml,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return WebviewScaffold(
        javascriptChannels: jsChannels,
        mediaPlaybackRequiresUserGesture: false,
        url:isHtml? Uri.dataFromString(url,
                          mimeType: 'text/html',
                          encoding: Encoding.getByName('utf-8'))
                      .toString():url,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: ThemeColors.titlesColor),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            title ?? "",
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
        ));
  }
}
