import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/model/goodsinfo.dart';
import 'package:flutter_cityshop_store/provide/common_provider.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/buildback.dart';
import 'package:flutter_cityshop_store/widget/searchbar.dart';
import 'package:flutter_cityshop_store/widget/wrapList.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SearchPages extends StatefulWidget {
  SearchPages({Key key}) : super(key: key);

  @override
  _SearchPagesState createState() => _SearchPagesState();
}

class _SearchPagesState extends State<SearchPages> {

  String query = "";

  List<Map> hotList = [

    {"title": "iPhone"},
    {"title": "秋冬季新款"},
    {"title": "代步车"},
    {"title": "男士秋冬款"},
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
                print("textFieldResults===$result");
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
      return ListView(children: [
        WrapList(hotGoodsList: result),
      ]);
    } else {
      return Column(
        children: <Widget>[
          _titleContainer("热卖搜索"),
          Container(
            width:ScreenUtil.screenWidth,
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
            print("热搜词专区---${val["title"]}");
              setState(() {
                  query = val["title"];
                });
             

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
}
