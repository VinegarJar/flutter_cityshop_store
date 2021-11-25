import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_cityshop_store/pages/index_page.dart';
import 'package:flutter_cityshop_store/pages/login/login_page.dart';

class Routes {
  // 路由管理
  static FluroRouter router;



  static Handler loginHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          LoginPage());

  static Handler indexRouteHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) =>
          IndexPages());

  static void setupRouter(FluroRouter router) {

    router.define(
      '/', // 这是路径
      handler: loginHandler,
    );
    router.define(
      'index', //命名参数
       handler: indexRouteHandler,
    );
  }

     


  // 路由管理
  // static FluroRouter router;

// //  loginHandler
//   static String login = '/login'; // 登录页
//   static String root = '/';
//   static String webView = '/webView'; // 网页加载
//   static String search = '/search';
//   static String cityList = '/cityList';
//   static String searchCity = '/searchCity';
//   static String animation = '/animation';
//   static String details = '/details';

//   static void configureRoutes(FluroRouter router) {
//     router.notFoundHandler = Handler(
//         handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//       print('ERROR====>ROUTE WAS NOT FONUND!!!');
//       return;
//     });

//     router.define(root, handler: rootRouteHandler);
//     router.define(webView, handler: webViewHandler);
//     router.define(cityList, handler: cityListPagesHandler);
//     router.define(searchCity, handler: searchCityHandler);
//     router.define(details, handler: detailsHandler);
//   }

  // cupertino, push效果
  // cupertinoFullScreenDialog, prentViewConter
  /*
   *   native,
  nativeModal,
  inFromLeft,
  inFromRight,
  inFromBottom,
  fadeIn,
  custom, // if using custom then you must also provide a transition
  material,
  materialFullScreenDialog,
  cupertino,
  cupertinoFullScreenDialog,  
   */

  // 对参数进行encode，解决参数中有特殊字符，影响fluro路由匹配R
  // static Future navigateTo(BuildContext context, String path,
  //     {Map<String, dynamic> params,
  //     TransitionType transition = TransitionType.cupertino}) {
  //   String query = "";
  //   if (params != null) {
  //     int index = 0;
  //     for (var key in params.keys) {
  //       var value = Uri.encodeComponent(params[key]);
  //       if (index == 0) {
  //         query = "?";
  //       } else {
  //         query = query + "\&";
  //       }
  //       query += "$key=$value";
  //       index++;
  //     }
  //   }
  //   // print('我是navigateTo传递的参数：$query');
  //   path = path + query;
  //   return router.navigateTo(context, path, transition: transition);
  // }
}
