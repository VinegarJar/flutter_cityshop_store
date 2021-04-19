import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/model/goodsinfo.dart';
import 'package:flutter_cityshop_store/provide/car_provider.dart';
import 'package:flutter_cityshop_store/provide/common_provider.dart';
import 'package:flutter_cityshop_store/utils/event_bus.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/add_car_botton.dart';
import 'package:flutter_cityshop_store/widget/add_car_count.dart';
import 'package:flutter_cityshop_store/widget/buildback.dart';
import 'package:flutter_cityshop_store/widget/searchbar.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SearchPages extends StatefulWidget {
  SearchPages({Key key}) : super(key: key);

  @override
  _SearchPagesState createState() => _SearchPagesState();
}

class _SearchPagesState extends State<SearchPages> {

 EasyRefreshController _controller = EasyRefreshController();

  String query = "";

  List<Map> hotList = [
    {"title": "iPhone"},
    {"title": "秋冬季新款"},
    {"title": "代步车"},
    {"title": "冰箱家用"},
    {"title": "全自动洗衣机"},
    {"title": "儿童床"},
  ];

  @override
  Widget build(BuildContext context) {
    final lisCache = Provider.of<CommonProvider>(context).lisCache;
    List<GoodsList> result = query.isEmpty
        ? []
        : lisCache.where((model) => model.goodsName.contains(query)).toList();

    return Scaffold(
       //关闭键盘顶起底部组件
       resizeToAvoidBottomInset: false,
      //  resizeToAvoidBottomPadding: false,
        backgroundColor: ThemeColors.mainBgColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: null,
          actions: [
            BuildBackActions(
              title: "取消",
            )
          ],
          titleSpacing: 8,
          title: SearchBar(
              searchFieldLabel: "千城小店热搜",
              bgColor: ThemeColors.mainBgColor,
              isTextField: true,
              textFieldResults: (String result) {
                setState(() {
                  // rebuild ourselves because query changed.
                  query = result;
                });
              }),
          centerTitle: true, //标题居中显示
        ),
        body: searchlist(result));
  }

  Widget searchlist(List result) {
    if (result.length > 0) {
  
      return Stack(
        children: [
          EasyRefresh(
            enableControlFinishRefresh: false,
            enableControlFinishLoad: true,
            controller: _controller,
           
            footer: ClassicalFooter(
              extent:130.w, 
              noMoreText: "没有更多啦!",
              showInfo: false,
              textColor: ThemeColors.titleColor,
            ),
            
            onLoad: () async {
         
              await Future.delayed(Duration(seconds: 1), () {
                _controller.finishLoad(noMore:true);
              });
            },
            child: ListView.builder(
              itemCount: result.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                GoodsList model = result[index];
                return itemCell(model);
              })
          ),
              Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: AddCarBottom(),
                      )
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          _titleContainer("热卖搜索"),
          Container(
            width: ScreenUtil.screenWidth,
            color: Colors.white,
            child: _wrapList(hotList),
          ),
        ],
      );
    }
  }

  Widget _titleContainer(String title) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: ScreenUtil().setWidth(15)),
              Text(title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(32)))
            ],
          ),
        ],
      ),
    );
  }

  //热搜词专区
  Widget _wrapList(List hotGoodsList) {
    List<Widget> listWidget = hotGoodsList.map((val) {
      return InkWell(
          onTap: () {
            eventBus.fire(new UserTextFieldInEvent(val["title"]));
          },
          child: Container(
              margin: EdgeInsets.only(left: 15, top: 5, bottom: 10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: ThemeColors.mainBgColor,
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setHeight(12))),
              child: Text(val["title"],
                  style: TextStyle(
                      color: ThemeColors.titleColor,
                      fontSize: ScreenUtil().setSp(28)))));
    }).toList();

    return Wrap(
      // spacing: 15, //左右
      // runSpacing: 5, //上下
      children: listWidget, //加载子组件
    );
  }

  Widget itemCell(GoodsList model) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.w,),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.w),
        //阴影位置由offset决定,阴影模糊层度由blurRadius大小决定（大就更透明更扩散），阴影模糊大小由spreadRadius决定
        boxShadow: [
          BoxShadow(
              color: ThemeColors.colorF6F6F8,
              offset: Offset(0.5, 0.5),
              blurRadius: 20.0,
              spreadRadius: 1.0),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 220.w,
            margin: EdgeInsets.only(top: 20.w, bottom: 20.w, left: 20.w),
            child: Image.network(model.imageUrl, fit: BoxFit.contain),
          ),
          Expanded(
              child: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.w),
                  child: Text(
                    model.goodsName,
                    style: TextStyle(
                        color: Colors.black, fontSize: ScreenUtil().setSp(28)),
                  )),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                    top: 10.w,
                  ),
                  child: Text(" 已销量 " + model.salesTip,
                      style: TextStyle(
                          color: ThemeColors.titleColor,
                          fontSize: ScreenUtil().setSp(26)))),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("￥" + model.marketPrice.toString().substring(0, 3),
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(32))),
                  Text(
                    "￥${model.group["price"].toString()}",
                    style: TextStyle(
                        color: Colors.black26,
                        fontSize: ScreenUtil().setSp(22),
                        decoration: TextDecoration.lineThrough), //价格横线显示样式
                  ),
                  Expanded(
                    child: AddCarCount(
                      addPressed: (int count) {
                    
                      Provider.of<CarProvider>(context, listen: false)
                        .addOrReduceAction(model);
                      },
                      reducePressed:(int count){
                     Provider.of<CarProvider>(context, listen: false)
                        .addOrReduceAction(model,isAdd:false);
                      }
                  ))
                ],
              )),
            ],
          ))
        ],
      ),
    );
  }

  

}
