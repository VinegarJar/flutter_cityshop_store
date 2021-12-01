import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_cityshop_store/common/event/http_error_event.dart';
import 'package:flutter_cityshop_store/https/code.dart';
import 'package:flutter_cityshop_store/provide/car_provider.dart';
import 'package:flutter_cityshop_store/provide/common_provider.dart';
import 'package:flutter_cityshop_store/router/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class StoreApp extends StatefulWidget {
  StoreApp({Key key}) : super(key: key);

  @override
  _StoreAppState createState() => _StoreAppState();
}

class _StoreAppState extends State<StoreApp> with HttpErrorListener{
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final router = FluroRouter();
    Routes.setupRouter(router);
    Routes.router = router;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CommonProvider()),
          ChangeNotifierProvider(create: (_) => CarProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false, //关闭显示debug模式
          initialRoute: '/', //配置路由
          onGenerateRoute: Routes.router.generator, //配置路由引用
        ));
  }
}


mixin HttpErrorListener on State<StoreApp> {
  StreamSubscription stream;

  @override
  void initState() {
    super.initState();

    ///Stream演示event bus
    stream = eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
  }

  ///网络错误提醒
  errorHandleFunction(int code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        showToast("网络错误");
        break;
      case 401:
        showToast("网络错误401");
        break;
      case 403:
        showToast("网络错误403");
        break;
      case 404:
        showToast("网络错误404");
        break;
      case 422:
        showToast("网络错误422");

        break;
      case Code.NETWORK_TIMEOUT:
        //超时
        showToast("网络连接超时");
        break;
      case Code.GITHUB_API_REFUSED:
        //Github API 异常
        showToast("API异常");
        break;
      default:
        showToast(message);
        break;
    }
  }

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG);
  }
}