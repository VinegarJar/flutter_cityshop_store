import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cityshop_store/store_app.dart';
import 'dart:io';

Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(StoreApp());
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      //这是设置状态栏的图标和字体的颜色
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyHttpOverrides extends HttpOverrides {
  //一种跳过SSL认证问题并解决Image.network(url)问题的方法是使用以下代码：
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
