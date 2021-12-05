import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';
import 'package:flutter_cityshop_store/https/httpRequest_method.dart';
import 'package:flutter_cityshop_store/model/homerecommed.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/item.dart';
import 'package:flutter_cityshop_store/widget/placeitem.dart';
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
  var params = {};

  @override
  void initState() {
    super.initState();

    // if (Platform.isAndroid) {
    //   params['isAndroid'] = "1";
    // } else {
    //   params['isIos'] = "1";
    // }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: ThemeColors.mainBgColor,
      appBar: AppBar(
        backgroundColor: ThemeColors.mainColor,
        title: Column(
          children: [
            Container(
              width: ScreenUtil().setWidth(245),
              child: Text(
                "分期借",
                style: TextStyle(
                    color: ThemeColors.titlesColor,
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtil().setSp(38)),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
              width: ScreenUtil().setWidth(245),
              child: Text(
                "专业贷款 审核更快",
                style: TextStyle(
                    color: ThemeColors.titlesColor,
                    fontSize: ScreenUtil().setSp(28)),
              ),
            )
          ],
        ),
      ),
      body: FutureBuilder(
        future: HttpRequestMethod.instance
            .requestWithMetod(Config.homeBankUrl, params),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          
          if (snapshot.hasData) {
            var res = snapshot.data;
           List<Map> list = (res.data as List).cast();
           List<HomeRecommed>dataSource = [];
          list.forEach((data) => dataSource.add(HomeRecommed.fromJson(data)));
            return ListView.builder(
              itemCount: dataSource.length,
              itemBuilder: (BuildContext context, int index) {
                HomeRecommed model = dataSource [index];
                
                return Item(model: model);
              },
            );
          } else {
                   return PlaceItem();
          }
        },
      ),
      // body: Container(
      //     // margin: EdgeInsets.only(left: 16, right: 16),
      //     alignment: Alignment.center,
      //     // padding: EdgeInsets.all(20),
      //     child: Column(
      //       children: [
      //         SizedBox(height: 20),
      //         Item(),

      //         InkWell(
      //           child: Text(
      //             "我是有底线滴",
      //             style:
      //                 TextStyle(color: ThemeColors.titleColor, fontSize: 26),
      //           ),
      //           onTap: () async {
      // var params = {};
      // if (Platform.isAndroid) {
      //   params['isAndroid'] = "1";
      // } else {
      //   params['isIos'] = "1";
      // }

      //             var res = await HttpRequestMethod.instance
      //                 .requestWithMetod(Config.homeBankUrl, params);
      // if (res.result) {
      //   print("获取首页贷款列表-特别推荐----${res.data}");
      // }
      //           },
      //         ),
      //       ],
      //     ))
    );
  }
}
