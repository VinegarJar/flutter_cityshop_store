import 'dart:io';

import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';
import 'package:flutter_cityshop_store/https/httpRequest_method.dart';
import 'package:flutter_cityshop_store/https/result_data.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePages extends StatefulWidget {
  HomePages({Key key}) : super(key: key);

  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages>
    with AutomaticKeepAliveClientMixin {
//保持 保持原页面State 状态 AutomaticKeepAliveClientMixin
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() async {
    super.initState();
    var params = {};
    if (Platform.isAndroid) {
      params['isAndroid'] = "1";
    } else {
      params['isIos'] = "1";
    }

    ResultData res = await HttpRequestMethod.instance
        .requestWithMetod(Config.homeBankUrl, params);
    if (res.result) {
      print("获取首页贷款列表-特别推荐---");
    }
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColors.mainColor,
          title: Text(
            "我是有底线滴",
            style: TextStyle(
                color: ThemeColors.titleColor,
                fontSize: ScreenUtil().setSp(26)),
          ),
          centerTitle: true, //标题居中显示
        ),
        body: Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Text(
            "我是有底线滴",
            style: TextStyle(
                color: ThemeColors.titleColor,
                fontSize: ScreenUtil().setSp(26)),
          ),
        ));
  }
}
