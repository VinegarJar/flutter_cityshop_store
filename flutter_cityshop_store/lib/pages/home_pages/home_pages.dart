import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/https/httpManager_method.dart';

import 'package:flutter_cityshop_store/router/routes.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/loding.dart';
import 'package:flutter_cityshop_store/widget/searchbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:flutter_cityshop_store/https/httpmanager_method.dart';

class HomePages extends StatefulWidget {
  HomePages({Key key}) : super(key: key);

  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  @override
  void initState() {
    super.initState();

    //  HttpManagerMethod.instance.requestWithMetod(
    //    categoryUrl,
    //    method: "post").then((value) {

    //   print("-------------------------------------");
    //  });
    // HttpManagerMethod.instance.requestWithMetod(
    //         "App/Api/homeHotCommendGoods",method: "post",).then((value) {
    //             print("-------------------------------------&value");
    //         });

    //   HttpManagerMethod.instance.requestWithMetod(
    //    goodsList,
    //    parameters: {'size': '50', 'page': 3},
    //    method: "get",baseUrl:"http://apiv2.yangkeduo.com/" ).then((value) {

    //   print("-------------------------------------");
    //  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ThemeColors.mainColor,
        title: SearchBar(
            isOpenCamera: true,
            onTapSearch: () {
              print("请求成功的处理");
            //  Routes.navigateTo(
            //     context,
            //     Routes.webView,
            //     params: {
            //       'title': "百度",
            //       'url': "https://www.baidu.com",
            //     },
            //   );
            },
            openCamera: () {
              print("请求失败的处理");
            }),
        centerTitle: true, //标题居中显示
      ),
      body: FutureBuilder(
          future: HttpManagerMethod.instance
              .requestWithMetod(hotcommendUrl, method: "post"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> swiperDataList =
                  (data['ads']['ads_list'] as List).cast();
              // print("----------------$swiperDataList---------------");

              return ListView(
                children: [
                  SwiperDiy(swiperDataList: swiperDataList), //页面顶部轮播组件
                  Text("加载中"),
                  WebviewScaffold(url: null)
                ],
              );
            } else {
              return LoadingWidget();
            }
          }),
    );
  }
}

// 首页轮播组件编写
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(265),
        width: ScreenUtil().setWidth(750),
        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
        color: Colors.white,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              // margin: const EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("${swiperDataList[index]['pic']}"),
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            );
          },

          itemCount: swiperDataList.length,
          pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
            color: Colors.white,
            activeColor: ThemeColors.mainColor,
            // 原点字体大小 size: ScreenUtil().setSp(30),
            // 当前的指示字体大小activeSize: ScreenUtil().setSp(35),
          )),
          scrollDirection: Axis.horizontal,
          autoplay: true,
          onIndexChanged: (index) {
            //  print('onIndexChanged$index个');
          },
          scale: 0.95, // 两张图片之间的间隔
          onTap: (index) {
            print('点击了第$index个');
            Routes.navigateTo(
              context,
              Routes.webView,
              params: {
                'title': swiperDataList[index]['title'],
                'url': swiperDataList[index]['link'],
              },
            );
          },
          // 展示窗口模式viewportFraction: 0.8,
        ));
  }
}
