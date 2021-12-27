import 'dart:io';

import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';
import 'package:flutter_cityshop_store/https/httpRequest_method.dart';
import 'package:flutter_cityshop_store/model/advert.dart';
import 'package:flutter_cityshop_store/model/homerecommed.dart';
import 'package:flutter_cityshop_store/pages/home/home_list_page.dart';
import 'package:flutter_cityshop_store/pages/home/home_title.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/home_banner.dart';
import 'package:flutter_cityshop_store/widget/placeitem.dart';
import 'package:flutter_cityshop_store/widget/tag.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

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

  EasyRefreshController _controller = EasyRefreshController();
  ScrollController scrollContr = ScrollController();
  var params = {};
  List<Advert> banner = [];

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      params['isAndroid'] = "1";
    } else {
      params['isIos'] = "1";
    }

    requstAdvert();
  }

  void requstAdvert() async {
    HttpRequestMethod.instance
        .requestWithMetod(Config.todayRecommed, params)
        .then((res) {
      List<Map> list = (res.data as List).cast();
      final List dataSource =
          list.map((data) => Advert.fromJson(data)).toList();
      setState(() {
        banner = dataSource;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: ThemeColors.mainBgColor,
      appBar: AppBar(
          elevation: 0, // 隐藏阴影
          backgroundColor: ThemeColors.homemainColor,
          title: HomeTitle()),
      body: FutureBuilder(
        future: HttpRequestMethod.instance
            .requestWithMetod(Config.homeBankUrl, params),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            var res = snapshot.data;
            List<Map> list = [];
            if ((res.data is List)) {
              list = (res.data as List).cast<Map>();
            }
            //  print('获取首页信息----res----${res.data}');
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
                    HomeBanner(bannner: banner, callBack: () {}),
                    Tage(titel: "特别推荐"),
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
