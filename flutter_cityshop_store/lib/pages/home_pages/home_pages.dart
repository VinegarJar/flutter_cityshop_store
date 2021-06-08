import 'package:fluro/fluro.dart';
import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/https/httpManager_method.dart';
import 'package:flutter_cityshop_store/model/goodsinfo.dart';
import 'package:flutter_cityshop_store/provide/common_provider.dart';
import 'package:flutter_cityshop_store/router/routes.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_cityshop_store/widget/loding.dart';
import 'package:flutter_cityshop_store/widget/searchbar.dart';
import 'package:flutter_cityshop_store/widget/swiper.dart';
import 'package:flutter_cityshop_store/widget/wraplist.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: ThemeColors.mainBgColor,
      floatingActionButton: FloatingActionButton(
        child: Image.asset(Utils.getImgPath('btn_category_top'),
            width: 30, height: 30, fit: BoxFit.contain),
        onPressed: () {
          print('FloatingActionButton');
          if (scrollContr.hasClients) {
            scrollContr.animateTo(
              0.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.decelerate,
            );
          }
        },
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.white,
        shape: CircleBorder(),
      ),
      appBar: AppBar(
        backgroundColor: ThemeColors.mainColor,
        title: SearchBar(
            isOpenCamera: true,
            onTapSearch: () {
              print("onTapSearch");
              Routes.navigateTo(context, Routes.search,
                  transition: TransitionType.cupertinoFullScreenDialog);
            },
            openCamera: () {
              print("openCamera");
            }),
        centerTitle: true, //标题居中显示
      ),
      body: FutureBuilder(
          future: HttpManagerMethod.instance
              .requestWithMetod(hotcommendUrl, method: "post"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              List<Map> swiperDataList =
                  (data['ads']['ads_list'] as List).cast();
              List<Map> navigatorList = (data['data']['lists'] as List).cast();
              GoodsInfoModel model = GoodsInfoModel.fromJson(data['goodsInfo']);

              Future.delayed(Duration(milliseconds: 200)).then((e) {
                Provider.of<CommonProvider>(context, listen: false)
                    .savaGoodsCache(model.goodsList);
              });

              return EasyRefresh(
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
                  onRefresh: () async {
                    await Future.delayed(Duration(seconds: 2), () {
                      print('onRefresh');
                      setState(() {});
                      _controller.resetLoadState();
                    });
                  },
                  child: ListView(
                    controller: scrollContr,
                    children: [
                      SwiperDiy(swiperDataList: swiperDataList), //页面顶部轮播组件
                      _titleWidget(navigatorList),
                      SizedBox(height: ScreenUtil().setHeight(20)),

                      _titleContainer("火爆专区"),
                      WrapList(hotGoodsList: model.goodsList),

                      Container(
                        margin: EdgeInsets.only(left: 16, right: 16),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "我是有底线滴",
                          style: TextStyle(
                              color: ThemeColors.titleColor,
                              fontSize: ScreenUtil().setSp(26)),
                        ),
                      )
                    ],
                  ));
            } else {
              return LoadingWidget();
            }
          }),
    );
  }

  ///封装推荐商品组件
  Widget _titleWidget(List list) {
    if (list.length > 0) {
      List<Widget> listWidget = list.map((val) {
        List productList = val["productList"];
        return Column(
          children: [
            SizedBox(height: ScreenUtil().setHeight(20)),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                  border: new Border.all(
                      color: ThemeColors.colorF6F6F8, width: 0.5),
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setHeight(12))),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(15),
                        height: ScreenUtil().setHeight(50),
                        color: ThemeColors.mainColor,
                      ),
                      SizedBox(width: ScreenUtil().setWidth(10)),
                      Text(val["tabName"],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(32)))
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  Container(
                      height: ScreenUtil().setHeight(300),
                      margin: EdgeInsets.only(left: 0, right: 0),
                      color: Colors.white,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productList.length,
                          itemBuilder: (contxt, index) {
                            Map item = productList[index];

                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                // print("点击热卖推荐--${item["name"]}");
                              },
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: ScreenUtil().setWidth(180),
                                    height: ScreenUtil().setHeight(220),
                                    margin: EdgeInsets.only(right: 10),
                                    child: FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage,
                                        image: item["pic"],
                                        fit: BoxFit.fill),
                                  ),
                                  Container(
                                    width: ScreenUtil().setWidth(180),
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "${item["name"]}",
                                      // maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: ThemeColors.titleColor,
                                        fontSize: ScreenUtil().setSp(18,
                                            allowFontScalingSelf: true),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })),
                ],
              ),
            )
          ],
        );
      }).toList();

      return Column(
        children: listWidget,
      );
    } else {
      return _titleContainer("猜你喜欢");
    }
  }

  Widget _titleContainer(String title) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(left: 16, right: 16),
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: ScreenUtil().setWidth(15),
                height: ScreenUtil().setHeight(50),
                color: ThemeColors.mainColor,
              ),
              SizedBox(width: ScreenUtil().setWidth(10)),
              Text(title,
                  style: TextStyle(
                      color: Colors.black, fontSize: ScreenUtil().setSp(32)))
            ],
          ),
        ],
      ),
    );
  }

  void dispose() {
    //为了避免内存泄露，需要调用 dispose
    scrollContr.dispose();
    super.dispose();
  }
}
