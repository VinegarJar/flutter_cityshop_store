import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/loding.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

String selectedUrl = 'https://www.baidu.com';

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

  const WebViewUrlPage({Key key, @required this.url, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        withJavascript: true,
        appCacheEnabled: true,
        withLocalUrl: true,
        hidden: true,
        allowFileURLs: true,
        withZoom: true,
        withLocalStorage: true,
        url: Uri.dataFromString(url, mimeType: 'text/html',encoding: Encoding.getByName('utf-8')).toString(),
        //new Uri.dataFromString(snapshot.data, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString(),
        javascriptChannels: jsChannels,
        mediaPlaybackRequiresUserGesture: false,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 18,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(title),
          centerTitle: true,
          backgroundColor: ThemeColors.mainColor, //标题居中显示
        ),
  

        initialChild: Container(
          color: Colors.white,
          child: Center(child: LoadingWidget()),
        ));
  }
}
