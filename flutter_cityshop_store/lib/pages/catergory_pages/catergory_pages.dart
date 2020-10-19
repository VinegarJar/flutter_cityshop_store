import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/https/httpmanager_method.dart';
import 'package:flutter_cityshop_store/model/category.dart';

import 'package:flutter_cityshop_store/router/routes.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/loding.dart';

import 'package:flutter_cityshop_store/widget/searchbar.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CaterGoryPages extends StatefulWidget {
  CaterGoryPages({Key key}) : super(key: key);

  @override
  _CaterGoryPagesState createState() => _CaterGoryPagesState();
}

class _CaterGoryPagesState extends State<CaterGoryPages> {

  List<Widget> tabs = [];
  List <Widget>tabViewWidget = [];

  @override
  void initState() {
    super.initState();
    HttpManagerMethod.instance
        .requestWithMetod(categoryUrl, method: "post")
        .then((data) {
      CategoryModel model = CategoryModel.fromJson(data);

      final List listWidget = model.results.map((results) {
        return Tab(
          child: Text(
            results.categoryName,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(32), fontWeight: FontWeight.w600),
          ),
        );
      }).toList();

      setState(() {
            tabs = listWidget;

      });

     List <Widget>goodsList = [];

     data["category"].forEach((element) {
            element["list"].forEach((elem) {
                goodsList.add(SingleChildScrollView(child:goodsWrap(elem["goods"])));
          });
      });
     setState(() {
       tabViewWidget =  goodsList ;
     });

    });

  }

  @override
  Widget build(BuildContext context) {
      if (tabs.length==0) {
             return LoadingWidget();
          } else {
           
            return DefaultTabController(
              length: tabs.length,
              child: Scaffold(
                  backgroundColor: ThemeColors.mainBgColor,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    bottom: TabBar(
                      indicatorColor:
                          ThemeColors.mainColor, //选中时下划线颜色,如果使用了indicator这里设置无效
                      labelColor: ThemeColors.mainColor,
                      unselectedLabelColor: ThemeColors.titleColor,
                      tabs: tabs,
                      isScrollable: true,
                      labelPadding: EdgeInsets.only(left: 15.w, right: 15.w),
                    ),
                    title: SearchBar(
                        bgColor: ThemeColors.mainBgColor,
                        isOpenCamera: true,
                        onTapSearch: () {
                          Routes.navigateTo(context, Routes.search,transition:TransitionType.cupertinoFullScreenDialog);
                        },
                        openCamera: () {
                          print("openCamera");
                        }),
                  ),
                  body: TabBarView(children: tabViewWidget)),
            );
          }
          
  }

  Widget goodsWrap(List hotGoodsList) {
    List<Widget> listWidget = hotGoodsList.map((val) {
      return InkWell(
          onTap: () {
            print("分类列表goodsWrap---$val---");
          },
          child: Container(
              // 375 默认宽度
              width: 330.w,
              margin: EdgeInsets.only(left: 30.w, top: 30.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.w)),
              child: Column(children: [
                SizedBox(height: 5),
                Image.network(val["pic"],
                    width: 330.w, height: 375.w, fit: BoxFit.contain),
                Container(
                  width: 330.w,
                  alignment: Alignment.center,
                  child: Text(
                    val["name"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: ThemeColors.titleColor, fontSize: 26.sp),
                  ),
                ),
                SizedBox(height: 5),
              ])));
    }).toList();
    return Wrap(
      // spacing: 7.5, //左右
      //runSpacing: 0, //上下
      children: listWidget, //加载子组件
    );
  }
}
