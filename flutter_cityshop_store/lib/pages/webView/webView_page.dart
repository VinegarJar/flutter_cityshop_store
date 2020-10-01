import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
 
 final String title;
  final String url;

  const WebViewUrlPage({Key key, this.title, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        url:url,
        javascriptChannels: jsChannels,
        mediaPlaybackRequiresUserGesture: false,
        appBar: AppBar(
          leading: IconButton(
              icon:Icon(Icons.arrow_back_ios,size: 18,),
              onPressed: (){Navigator.pop(context);
          }),
          title:Text(title),
          centerTitle: true, //标题居中显示
        ),
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
        initialChild: Container(
          color: Colors.white,
          child: Center(child: LoadingWidget()),
        )
    );
    
  }
}
