import 'package:fluro/fluro.dart';
import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/https/httpmanager_method.dart';
import 'package:flutter_cityshop_store/model/goodsinfo.dart';
import 'package:flutter_cityshop_store/provide/common_provider.dart';
import 'package:flutter_cityshop_store/router/routes.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/wrapList.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CarPages extends StatefulWidget {
  CarPages({Key key}) : super(key: key);

  @override
  _CarPagesState createState() => _CarPagesState();
}

class _CarPagesState extends State<CarPages> {
  EasyRefreshController _controller = EasyRefreshController();
  ScrollController scrollContr = ScrollController();

  // ignore: deprecated_member_use
  List<GoodsList> goodsListData = [];
  int page = 1;
  @override
  void initState() {
    super.initState();
    getGoodsListData();
  }

  void getGoodsListData({int pages = 0}) async {
    // print('onRefresh-----$pages');
    await HttpManagerMethod.instance
        .requestWithMetod(goodsListUrl,
            parameters: {'size': '50', 'page': page},
            baseUrl: "http://apiv2.yangkeduo.com/")
        .then((data) {
      print('data-----$data');
      GoodsInfoModel model = GoodsInfoModel.fromJson(data);

      setState(() {
        goodsListData.addAll(model.goodsList);
        page++;
      });
      Future.delayed(Duration(milliseconds: 200)).then((e) {
        Provider.of<CommonProvider>(context, listen: false)
            .savaGoodsCache(model.goodsList);
      });
    }).catchError((onError) {
      print('onError-----$onError');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColors.mainBgColor,
        appBar: AppBar(
          backgroundColor: ThemeColors.mainColor,
          title: _titleHeader(),
          centerTitle: true, //标题居中显示
        ),
        body: EasyRefresh(
            enableControlFinishRefresh: false,
            enableControlFinishLoad: true,
            controller: _controller,
            header: ClassicalHeader(
              refreshText: "松手刷新",
              refreshReadyText: "松手刷新",
              refreshingText: "更新中",
              refreshedText: "刷新完成",
              refreshFailedText: "刷新失败",
              infoText: "",
              textColor: ThemeColors.mainColor,
            ),
            footer: ClassicalFooter(
              loadingText: "正在加载更多",
              loadedText: "加载成功!",
              loadFailedText: "加载失败",
              noMoreText: "我是有底线滴!",
              showInfo: false,
              textColor: ThemeColors.mainColor,
              infoColor: Colors.pink,
            ),
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 2), () {
                print('onRefresh');
                setState(() {
                  page = 1;
                });
                goodsListData.clear();
                getGoodsListData();
              });
            },
            onLoad: () async {
              await Future.delayed(Duration(seconds: 2), () {
                getGoodsListData();
                _controller.finishLoad(noMore: page >= 6);
              });
            },
            child: ListView(
              controller: scrollContr,
              children: [
                SizedBox(height: ScreenUtil().setHeight(20)),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.heart_solid,
                          size: 20, color: ThemeColors.mainColor),
                      Text(
                        "为你推荐!",
                        style: TextStyle(
                            color: ThemeColors.titleColor,
                            fontSize: ScreenUtil().setSp(30)),
                      ),
                    ],
                  ),
                ),
                WrapList(hotGoodsList: goodsListData),
              ],
            )));
  }

  Widget _titleHeader() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      padding: EdgeInsets.all(5),
      alignment: Alignment.center,
      child: InkWell(
          onTap: () {
            Routes.navigateTo(context, Routes.cityList,
                transition: TransitionType.cupertinoFullScreenDialog);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("购物车",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(36))),
              SizedBox(width: ScreenUtil().setWidth(10)),
              Icon(CupertinoIcons.location_solid,
                  size: 18, color: Colors.white),
              Text(
                "北京",
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(20)),
              ),
            ],
          )),
    );
  }
}
