import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_cityshop_store/pages/citylist_pages/citylist_pages.dart';
import 'package:flutter_cityshop_store/pages/citylist_pages/citysearch.dart';
import 'package:flutter_cityshop_store/pages/index_page.dart';
import 'package:flutter_cityshop_store/pages/search_pages/search_pages.dart';
import 'package:flutter_cityshop_store/pages/webView/webView_page.dart';



Handler rootRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return IndexPages();
});


Handler searchPagesHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SearchPages();
});


Handler cityListPagesHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CityListPages();
});


Handler searchCityHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CitySearchResult();
});




// 网页加载 - 示例：传多个字符串参数 CityListPages
Handler webViewHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {

  Map dict = getJsonParamsHandler(params);
  print(' title传递的参数：$dict');
  return WebViewUrlPage(
    title: dict["title"],
    url: dict["url"],
  );
});


Map  getJsonParamsHandler(Map<String, dynamic> params){
  Map dict = Map();
  if (params.isNotEmpty) {
    params.forEach((key, value) {
      String title = value.toString();
      String name = title.substring(1, title.length - 1);
      dict[key] = name;
    });
  }
  return dict;
}
