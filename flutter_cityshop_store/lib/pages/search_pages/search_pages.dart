import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/searchbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPages extends StatefulWidget {
  SearchPages({Key key}) : super(key: key);

  @override
  _SearchPagesState createState() => _SearchPagesState();
}

class _SearchPagesState extends State<SearchPages> {
  List<Map> hotList = [
    {"title": "国庆自驾游必备神器"},
    {"title": "出行护肤品第一位"},
    {"title": "国庆出游行"},
    {"title": "房车洗衣机"},
    {"title": "男士洁面"},
    {"title": "Wi-Fi电视"},
    {"title": "iPhone原装充电器"},
    {"title": "秋冬季新款"},
    {"title": "电水壶美的"},
    {"title": "皮带LV男士"},
    {"title": "精致女生护肤第一步"},

  
  ];

  List<Widget> buildActions(BuildContext context) {
    return [
      InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          alignment: Alignment.center,
          child: Text("取消",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(38))),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.mainBgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: null,
        actions: buildActions(context),
        titleSpacing: 8,
        title: SearchBar(
            searchFieldLabel: "千城小店热搜",
            bgColor: ThemeColors.mainBgColor,
            isTextField: true,
            textFieldResults: (String result) {
              print("textFieldResults===$result");
            }),
        centerTitle: true, //标题居中显示
      ),
      body: ListView(
        children: <Widget>[
          _titleContainer("热卖搜索"),
          Container(
            color: Colors.white,
            child:_wrapList(hotList),
          ),
    
        ],
      ),
    );
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

  //火爆专区
  Widget _wrapList(List hotGoodsList) {
    List<Widget> listWidget = hotGoodsList.map((val) {
      return InkWell(
          onTap: () {
            print("火爆专区---${val["title"]}");
          },
          child: Container(
              margin: EdgeInsets.only(left: 15, top: 5,bottom: 10),
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
