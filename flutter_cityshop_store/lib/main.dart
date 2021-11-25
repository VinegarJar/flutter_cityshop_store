import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_cityshop_store/provide/car_provider.dart';
import 'package:flutter_cityshop_store/provide/common_provider.dart';
import 'package:flutter_cityshop_store/router/routes.dart';
import 'package:provider/provider.dart';
import 'dart:io';

Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();

  runApp(MyApp());

  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      //这是设置状态栏的图标和字体的颜色
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  //asyncFibonacci函数里会创建一个isolate，并返回运行结果
  // print(await asyncFibonacci(20));
  // sendPortIsolate();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = FluroRouter();
    Routes.setupRouter(router);
    Routes.router = router;

    // Routes.setupRouter(FluroRouter());

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CommonProvider()),
          ChangeNotifierProvider(create: (_) => CarProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false, //关闭显示debug模式
          initialRoute: '/', //配置路由
          onGenerateRoute: Routes.router.generator, //配置路由引用
          // title: '借呗',
          // theme: ThemeData(primaryColor: Colors.white, fontFamily: 'Raleway'),
        ));
  }
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
