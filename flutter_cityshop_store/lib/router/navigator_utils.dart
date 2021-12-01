/*
 * 导航栏
 * Date: 2021-11-25
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/pages/home/home_pages.dart';
import 'package:flutter_cityshop_store/pages/mine/mine_pages.dart';
import 'package:flutter_cityshop_store/pages/webView/webView_page.dart';
import 'package:flutter_cityshop_store/widget/never_overscroll_indicator.dart';

class NavigatorUtils {
  ///主页(路由替换)
  static goHome(BuildContext context) {
    // Navigator.pushReplacementNamed(context, 'index');
    Navigator.pushNamedAndRemoveUntil(context, 'index', (route) => false);
  }


  ///登录页(路由替换)
  static goLogin(BuildContext context) {
     Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    // Navigator.pushReplacementNamed(context, "/");
  }

  ///切换无参数页面
  static pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  ////////////////////////////////////调试代码///////////////////////////////
  ////////////////////////////////////调试代码///////////////////////////////
  ////////////////////////////////////调试代码///////////////////////////////

  ///图片预览
  static gotoPhotoViewPage(BuildContext context, String url) {
    Navigator.pushNamed(context, "PhotoViewPage.sName", arguments: url);
  }

  ///个人中心
  static goPerson(BuildContext context, String userName) {
    NavigatorRouter(context, HomePages());
  }

  ///请求数据调试页面
  static goDebugDataPage(BuildContext context) {
    return NavigatorRouter(context, new HomePages());
  }

  ///仓库详情
  static Future goReposDetail(
      BuildContext context, String userName, String reposName) {
    ///利用 SizeRoute 动画大小打开
    return Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              // HomePages(userName, reposName),
              HomePages(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            double begin = 0;
            double end = 1;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return Align(
              child: SizeTransition(
                sizeFactor: animation.drive(tween),
                child: NeverOverScrollIndicator(
                  needOverload: false,
                  child: child,
                ),
              ),
            );
          },
        ));
  }

  ///荣耀列表
  static Future goHonorListPage(BuildContext context, List list) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            // HonorListPage(list),
            HomePages(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          double begin = 0;
          double end = 1;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return Align(
            child: SizeTransition(
              sizeFactor: animation.drive(tween),
              child: NeverOverScrollIndicator(
                needOverload: false,
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }

  ///仓库详情通知
  static Future goNotifyPage(BuildContext context) {
    return NavigatorRouter(context, HomePages());
  }

  ///用户趋势
  static Future goTrendUserPage(BuildContext context) {
    return NavigatorRouter(context, HomePages());
  }

  ///搜索
  static Future goSearchPage(BuildContext context, Offset centerPosition) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Builder(builder: (BuildContext context) {
          return pageContainer(HomePages(), context);
        });
      },
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Color(0x01000000),
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: child,
        );
      },
    );
  }

  ///全屏Web页面
  static Future goGSYWebView(BuildContext context, String url, String title) {
    return NavigatorRouter(context, WebViewUrlPage(title: title, url: url));
  }

  ///登陆Web页面
  static Future goLoginWebView(BuildContext context, String url, String title) {
    return NavigatorRouter(context, WebViewUrlPage(title: title, url: url));
  }

  ///文件代码详情Web
  static gotoCodeDetailPageWeb(BuildContext context,
      {String title,
      String userName,
      String reposName,
      String path,
      String data,
      String branch,
      String url}) {
    NavigatorRouter(context, WebViewUrlPage(title: title, url: url));
  }

  ///根据平台跳转文件代码详情Web
  static gotoCodeDetailPlatform(BuildContext context,
      {String title,
      String userName,
      String reposName,
      String path,
      String data,
      String branch,
      String htmlUrl}) {
    NavigatorUtils.gotoCodeDetailPageWeb(
      context,
      title: title,
      reposName: reposName,
      userName: userName,
      data: data,
      path: path,
      branch: branch,
    );
  }

  ///用户配置
  static gotoUserProfileInfo(BuildContext context) {
    NavigatorRouter(context, MinePages());
  }

  ///公共打开方式
  // ignore: non_constant_identifier_names
  static NavigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => pageContainer(widget, context)));
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

  ///弹出 dialog
  static Future<T> showGSYDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(

              ///不受系统字体缩放影响
              data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .copyWith(textScaleFactor: 1),
              child: NeverOverScrollIndicator(
                needOverload: false,
                child: new SafeArea(child: builder(context)),
              ));
        });
  }
}
