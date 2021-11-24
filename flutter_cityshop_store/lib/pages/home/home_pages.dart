import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
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
  void initState() {
    super.initState();
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
