/*
 * 导航栏
 * Date: 2021-11-25
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/pages/index_page.dart';
import 'package:flutter_cityshop_store/pages/login/login_page.dart';
import 'package:flutter_cityshop_store/pages/webView/webView_page.dart';
import 'package:flutter_cityshop_store/widget/never_overscroll_indicator.dart';

class NavigatorUtils {
  ///主页(路由替换)
  static goHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, IndexPages.name, (route) => false);
  }

  ///登录页(路由替换)
  static goLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, LoginPage.name, (route) => false);
  }

  ///切换无参数页面
  static pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  ///Page页面的容器，做一次通用自定义
  static Widget pageContainer(widget, BuildContext context) {
    return MediaQuery(
        ///不受系统字体缩放影响
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: NeverOverScrollIndicator(
          needOverload: false,
          child: widget,
        ));
  }

   static Future goWebView(BuildContext context, String url, String title) {
    return NavigatorUtils.NavigatorRouter(context, WebViewUrlPage(url: url, title: title,));
  }

  // ignore: non_constant_identifier_names
  static NavigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(
        context,
        new CupertinoPageRoute(
            builder: (context) => pageContainer(widget, context)));
  }
}
