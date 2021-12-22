/*
 * 导航栏
 * Date: 2021-11-25
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/pages/associator/associator_page.dart';
import 'package:flutter_cityshop_store/pages/index_page.dart';
import 'package:flutter_cityshop_store/pages/login/login_page.dart';
import 'package:flutter_cityshop_store/pages/mine/system/system_page.dart';
import 'package:flutter_cityshop_store/pages/vip/vip_page.dart';
import 'package:flutter_cityshop_store/pages/vip/vip_pay_page.dart';
import 'package:flutter_cityshop_store/pages/webView/flutter_web_page.dart';
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
 
    ///我的会员
  static gotoAssociatorPages(BuildContext context) {
     return NavigatorUtils.NavigatorRouter(
        context, AssociatorPages());
  }

  // 去购买VipPages
    static gotoVipPages(BuildContext context) {
     return NavigatorUtils.NavigatorRouter(
        context, VipPages());
  }
  //去支付
  static gotoPayVip(BuildContext context) {
     return NavigatorUtils.NavigatorRouter(
        context, VipPayPages());
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


  static goProductWebView(BuildContext context, String resultUrl, String title) {
   return  Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(
          builder: (BuildContext context) => FlutterWebPage(resultUrl: resultUrl, title: title)));
  }

  static goWebView(BuildContext context, String url, String title) {
    return NavigatorUtils.NavigatorRouter(
        context, WebViewUrlPage(url: url, title: title,isHtml: false));
  }
 
  static Future goToHtmlWebView(BuildContext context, String url, String title) {
    return NavigatorUtils.NavigatorRouter(
        context, WebViewUrlPage(url: url, title: title, isHtml: true));
  }

 


  ///用户配置
  static gotoUserSystem(BuildContext context) {
    NavigatorRouter(context, SystemPage());
  }

  // ignore: non_constant_identifier_names
  static NavigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(
        context, CupertinoPageRoute(
            builder: (context) => pageContainer(widget, context)));
  }
}
