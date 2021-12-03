/*
 * 导航栏
 * Date: 2021-11-25
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/pages/index_page.dart';
import 'package:flutter_cityshop_store/pages/login/login_page.dart';

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
}
