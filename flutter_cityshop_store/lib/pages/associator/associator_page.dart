import 'dart:io';

import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';
import 'package:flutter_cityshop_store/https/httpRequest_method.dart';
import 'package:flutter_cityshop_store/model/homerecommed.dart';
import 'package:flutter_cityshop_store/model/userinfo.dart';
import 'package:flutter_cityshop_store/provide/user_provider.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_cityshop_store/widget/associator.dart';
import 'package:flutter_cityshop_store/widget/tag.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class AssociatorPages extends StatefulWidget {
  AssociatorPages({Key key}) : super(key: key);

  @override
  _AssociatorPagesState createState() => _AssociatorPagesState();
}

class _AssociatorPagesState extends State<AssociatorPages> {
  List<dynamic> dataSource = [];

  @override
  void initState() {
    super.initState();
    rquestRecommed();
  }

  void rquestRecommed() async {
    var params = {};
    if (Platform.isAndroid) {
      params['isAndroid'] = "1";
    } else {
      params['isIos'] = "1";
    }
    var res = await HttpRequestMethod.instance
        .requestWithMetod(Config.productRecommed, params);
    print("为加入会员---$res");
    final List source =
        res.data.map((data) => HomeRecommed.fromJson(data)).toList();

    List goodsList = [];

    for (var i = 0; i < 3; i++) {
      source.forEach((element) {
        goodsList.add(element);
      });
    }

    setState(() {
      dataSource = goodsList;
    });
  }

  Widget _userInfo(UserInfo userInfo) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(30)),
        color: Colors.white,
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(
                    bottom: ScreenUtil().setWidth(15),
                    left: ScreenUtil().setWidth(40),
                    right: ScreenUtil().setWidth(20)),
                width: ScreenUtil().setWidth(120),
                height: ScreenUtil().setWidth(120),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage(Utils.getImgPath('head_image')),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().setWidth(60))))),
            Container(
              height: ScreenUtil().setWidth(120),
              margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userInfo?.nickName ?? "未实名认证",
                      style: TextStyle(
                          color: ThemeColors.titlesColor,
                          fontSize: ScreenUtil().setSp(32)),
                      textAlign: TextAlign.left),
                  Text("有效期:" + userInfo?.vipLevel.toString() + "个月",
                      style: TextStyle(
                          color: ThemeColors.titlesColor,
                          fontSize: ScreenUtil().setSp(30)),
                      textAlign: TextAlign.left),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _associatorCheck() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Tage(titel: "会员精选"),
          _wrapList(),
          SizedBox(
            height: ScreenUtil().setWidth(15),
          )
        ],
      ),
    );
  }

  //会员精选专区
  Widget _wrapList() {
    if (dataSource.length != 0) {
      List<Widget> listWidget = dataSource.map((val) {
        HomeRecommed model = val;
        return InkWell(
            onTap: () {
              print("会员精选专区---$val---");
            },
            child: Column(
              children: [
                Container(
                  width: ScreenUtil().setWidth(365),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setWidth(30),
                            horizontal: ScreenUtil().setWidth(20)),
                        width: ScreenUtil().setWidth(100),
                        height: ScreenUtil().setHeight(100),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage("${model?.productImgUrl}"),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().setHeight(20)))),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setWidth(30)),
                        height: ScreenUtil().setHeight(100),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model?.productName ?? "",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(36),
                                color: ThemeColors.titlesColor,
                              ),
                            ),
                            Text(
                              computeLongContent(
                                  model?.loanLower, model?.loanUpper),
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(38),
                                  fontWeight: FontWeight.w600,
                                  color: ThemeColors.loanUpperColor),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(365),
                  height: ScreenUtil().setWidth(1),
                  color: ThemeColors.deleteColor,
                )
              ],
            ));
      }).toList();

      return Wrap(
        spacing: ScreenUtil().setWidth(20), //左右
        runSpacing: ScreenUtil().setWidth(20), //上下
        children: listWidget, //加载子组件
      );
    } else {
      return Container();
    }
  }

  computeLongContent(var minimum, var maximum) {
    String min;
    if (minimum != null && minimum > 10000) {
      min = (minimum / 10000).truncate().toString() + "万";
    } else {
      min = minimum?.toString() ?? "0";
    }
    String max;
    if (maximum != null && maximum > 10000) {
      max = (maximum / 10000).truncate().toString() + "万";
    } else {
      max = maximum?.toString() ?? "0";
    }
    return (min + "~" + max);
  }

  Widget build(BuildContext context) {
    UserInfo userInfo = Provider.of<UserProvider>(context).userInfo;
    return Scaffold(
        backgroundColor: ThemeColors.mainBgColor,
        appBar: AppBar(
            elevation: 0, // 隐藏阴影
            backgroundColor: ThemeColors.homemainColor,
            title: Text(
              "我的会员",
              style: TextStyle(
                  color: ThemeColors.titlesColor,
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenUtil().setSp(38)),
            ),
            centerTitle: true,
            leading: IconButton(
                icon:
                    Icon(Icons.arrow_back_ios, color: ThemeColors.titlesColor),
                onPressed: () {
                  Navigator.pop(context);
                })),
        body: ListView(
          children: [
            _userInfo(userInfo),
            Associator(),
            SizedBox(
              height: ScreenUtil().setWidth(20),
            ),
            _associatorCheck(),
          ],
        ));
  }
}
