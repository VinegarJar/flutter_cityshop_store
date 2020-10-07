import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/https/httpmanager_method.dart';
import 'package:flutter_cityshop_store/model/category.dart';
import 'package:flutter_cityshop_store/provide/common_provider.dart';
import 'package:flutter_cityshop_store/router/routes.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/loding.dart';
import 'package:flutter_cityshop_store/widget/searchbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CaterGoryPages extends StatefulWidget {
  CaterGoryPages({Key key}) : super(key: key);

  @override
  _CaterGoryPagesState createState() => _CaterGoryPagesState();
}

class _CaterGoryPagesState extends State<CaterGoryPages> {
  @override
  void initState() {
    super.initState();
    HttpManagerMethod.instance
        .requestWithMetod(categoryUrl, method: "post")
        .then((value) {
      var data = json.decode(value.toString());
      CategoryModel model = CategoryModel.fromJson(data);
      Provider.of<CommonProvider>(context, listen: false).savaCategory(model);
      // print("获取分类列表数据----${model.results}-----${model.category}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: SearchBar(
              bgColor: ThemeColors.mainBgColor,
              isOpenCamera: true,
              onTapSearch: () {
                Routes.navigateTo(context, Routes.search);
              },
              openCamera: () {
                print("openCamera");
              }),
          centerTitle: true, //标题居中显示
        ),
        body: Container(
          child: Row(
            children: <Widget>[LeftCategoryNav(), RightCategorGoodsList()],
          ),
        ));
  }
}

class LeftCategoryNav extends StatefulWidget {
  LeftCategoryNav({Key key}) : super(key: key);

  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  var isSelect = 0; //索引

  @override
  Widget build(BuildContext context) {
    List<Results> results = Provider.of<CommonProvider>(context).results;

    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            bool isClick = (index == isSelect) ? true : false;

            return InkWell(
              onTap: () {
                setState(() {
                  isSelect = index;
                });

                // changeCategoryList
                Provider.of<CommonProvider>(context, listen: false)
                    .changeCategoryList(index);
              },
              child: Container(
                alignment: Alignment.center,
                height: ScreenUtil().setHeight(88),
                decoration: BoxDecoration(
                    color: isClick ? Colors.white : ThemeColors.mainBgColor,
                    border: Border(
                        bottom: BorderSide(width: 0.8, color: Colors.black12))),
                child: Row(
                  children: [
                    Container(
                      width: ScreenUtil().setWidth(12),
                      margin:
                          EdgeInsets.only(left: 1, right: 5, top: 8, bottom: 8),
                      color: isClick ? ThemeColors.mainColor : Colors.white,
                    ),
                    Text(
                      results[index].categoryName,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(28),
                          fontWeight:
                              isClick ? FontWeight.w700 : FontWeight.w400),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class RightCategorGoodsList extends StatefulWidget {
  RightCategorGoodsList({Key key}) : super(key: key);

  @override
  _RightCategorGoodsListState createState() => _RightCategorGoodsListState();
}

class _RightCategorGoodsListState extends State<RightCategorGoodsList> {
  var scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    List<ListItem> category = Provider.of<CommonProvider>(context).category;

    if (category.length > 0) {
      String title = category[0].title;
      List goods = category[0].goods;

      return Expanded(
          child: Container(
              width: ScreenUtil().setWidth(570),
              child: ListView(
                children: [
                  _title(title),
                  _wrapList(goods),
                ],
              )));
    } else {
      return Container(
        width: ScreenUtil().setWidth(570),
        child: LoadingWidget(),
      );
    }

    // print("=========$goods=========");
  }

  Widget _title(String title) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(left: 0, right: 0),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: ScreenUtil().setWidth(10)),
              Text(title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: ScreenUtil().setSp(32)))
            ],
          ),
        ],
      ),
    );
  }

  Widget _wrapList(List hotGoodsList) {
    List<Widget> listWidget = hotGoodsList.map((val) {
      return InkWell(
          highlightColor:Colors.transparent,
          radius: 0.0,
          onTap: () {
            print("火爆专区---$val");
          },
          child: Container(
             color: Colors.white,
              width: ScreenUtil().setWidth(190),
              child: Column(children: [
                SizedBox(
                  height: 5,
                ),
                Image.network(val["pic"],
                    width: ScreenUtil().setWidth(180),
                    height: ScreenUtil().setWidth(180),
                    fit: BoxFit.contain),
                Container(
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Text(
                    val["name"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ThemeColors.titleColor,
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  ),
                ),
              ])));
    }).toList();

    return Wrap(
      // spacing: 7.5, //左右
      // runSpacing: ScreenUtil().setWidth(10), //上下
      children: listWidget, //加载子组件
    );
  }
}
