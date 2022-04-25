import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';
import 'package:flutter_cityshop_store/https/httpRequest_method.dart';
import 'package:flutter_cityshop_store/model/homerecommed.dart';
import 'package:flutter_cityshop_store/pages/home/home_list_page.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/placeitem.dart';
import 'package:flutter_cityshop_store/widget/tag.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CaterGoryPages extends StatefulWidget {
  CaterGoryPages({Key key}) : super(key: key);

  @override
  _CaterGoryPagesState createState() => _CaterGoryPagesState();
}

class _CaterGoryPagesState extends State<CaterGoryPages> {
  EasyRefreshController _controller = EasyRefreshController();
  ScrollController scrollContr = ScrollController();
  var params = {};

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      params['isAndroid'] = "1";
    } else {
      params['isIos'] = "1";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.mainBgColor,
      appBar: AppBar(
          elevation: 0, // 隐藏阴影
          backgroundColor: ThemeColors.homemainColor,
          title: Text(
            "借款",
            style: TextStyle(
                color: ThemeColors.titlesColor,
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtil().setSp(38)),
          ),
          centerTitle: true),
      body: FutureBuilder(
        future: HttpRequestMethod.instance
            .requestWithMetod(Config.productRecommed, params),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            var res = snapshot.data;
            // print('获取CaterGoryPages信息----res----${res.data}');
            List<Map> list = [];
            if ((res.data is List)) {
              list = (res.data as List).cast<Map>();
            }
            final List dataSource =
                list.map((data) => HomeRecommed.fromJson(data)).toList();
            return EasyRefresh(
                enableControlFinishRefresh: false,
                enableControlFinishLoad: true,
                controller: _controller,
                header: ClassicalHeader(
                  refreshText: "松手刷新",
                  refreshReadyText: "松手刷新",
                  refreshingText: "更新中",
                  refreshedText: "更新成功",
                  refreshFailedText: "更新失败",
                  infoText: "",
                  textColor: ThemeColors.homemainColor,
                ),
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 2), () {
                    print('onRefresh');
                    setState(() {});
                    _controller.resetLoadState();
                  });
                },
                child: ListView(
                  children: [
                    // Associator(),
                    Tage(),
                    HomeListPage(dataSource: dataSource)
                  ],
                ));
          } else {
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return PlaceItem();
              },
            );
          }
        },
      ),
    );
  }
}
