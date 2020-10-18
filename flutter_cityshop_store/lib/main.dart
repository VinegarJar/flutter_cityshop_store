import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_cityshop_store/provide/car_provider.dart';
import 'package:flutter_cityshop_store/provide/common_provider.dart';
import 'package:flutter_cityshop_store/router/routes.dart';
import 'package:provider/provider.dart';

//
main() {
  runApp(MyApp());
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      //这是设置状态栏的图标和字体的颜色
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configureRoutes(router);
    Routes.router = router;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<CommonProvider>.value(value: CommonProvider()),
          ChangeNotifierProvider<CarProvider>.value(value: CarProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false, //关闭显示debug模式
          initialRoute: '/', //配置路由
          onGenerateRoute: Routes.router.generator, //配置路由引用
          title: '千城小店',
          theme: ThemeData(primaryColor: Colors.white, fontFamily: 'Raleway'),
        ));
  }
}
