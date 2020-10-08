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
        .then((data) {
      CategoryModel model = CategoryModel.fromJson(data);
      Provider.of<CommonProvider>(context, listen: false).savaCategory(model);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.mainBgColor,
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
      body: ListView(
        children: [
          CategoryNavTally(),
          CategorGoodsList(),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: Text(
              "我到底线了",
              style: TextStyle(
                  color: ThemeColors.titleColor,
                  fontSize: ScreenUtil().setSp(30)),
            ),
          )
        ],
      ),
    );
  }
}

class CategoryNavTally extends StatefulWidget {
  CategoryNavTally({Key key}) : super(key: key);

  @override
  _CategoryNavTallyState createState() => _CategoryNavTallyState();
}

class _CategoryNavTallyState extends State<CategoryNavTally> {
  ScrollController scrollContr = ScrollController();
  int scrollIndex = 0;
  void dispose() {
    //为了避免内存泄露，需要调用 dispose
    scrollContr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Results> results = Provider.of<CommonProvider>(context).results;

    final selectedIndex = Provider.of<CommonProvider>(context).selectedIndex;

    return Container(
        height: ScreenUtil().setHeight(128),
        child: ListView.builder(
            controller: scrollContr,
            itemCount: results.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              bool isSelected = (index == selectedIndex) ? true : false;
              return InkWell(
                  onTap: () {
                    // if (scrollContr.hasClients) {
                    //   scrollIndex +=(index+70);
                    //   scrollContr.animateTo(double.parse((scrollIndex).toString()),
                    //       duration: Duration(milliseconds: 200),
                    //       curve: Curves.ease);
                    // }
                    Provider.of<CommonProvider>(context, listen: false)
                        .changeCategoryList(index);
                  },
                  child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      results[index].categoryName,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(28),
                          fontWeight:
                              isSelected ? FontWeight.w800 : FontWeight.w400),
                    ),
                  ));
            }));
  }
}

class CategorGoodsList extends StatefulWidget {
  CategorGoodsList({Key key}) : super(key: key);

  @override
  _CategorGoodsListState createState() => _CategorGoodsListState();
}

class _CategorGoodsListState extends State<CategorGoodsList> {
  var scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    List<ListItem> category = Provider.of<CommonProvider>(context).category;

    if (category.length > 0) {
      List goods = category[0].goods;
      return _wrapGoodsList(goods);
    } else {
      return LoadingWidget();
    }
  }

  Widget _wrapGoodsList(List hotGoodsList) {
    List<Widget> listWidget = hotGoodsList.map((val) {
      return InkWell(
          onTap: () {
            print("火爆专区---$val");
          },
          child: Container(
              margin: EdgeInsets.only(
                  top: ScreenUtil().setWidth(30),
                  left: ScreenUtil().setWidth(30)),
              decoration: BoxDecoration(
                  border: new Border.all(
                      color: ThemeColors.colorF6F6F8, width: 0.5),
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setHeight(12))),
              child: Column(children: [
                SizedBox(
                  height: 5,
                ),
                Image.network(val["pic"],
                    width: ScreenUtil().setWidth(330),
                    height: ScreenUtil().setWidth(375),
                    fit: BoxFit.contain),
                Container(
                  // margin:EdgeInsets.all(2),
                  width: ScreenUtil().setWidth(330),
                  alignment: Alignment.center,
                  child: Text(
                    val["name"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: ThemeColors.titleColor,
                        fontSize: ScreenUtil().setSp(26)),
                  ),
                ),
              ])));
    }).toList();

    return Wrap(
      //spacing: ScreenUtil().setWidth(20), //左右
      // runSpacing: ScreenUtil().setWidth(20), //上下
      children: listWidget, //加载子组件
      alignment: WrapAlignment.start, //左右
      //runAlignment: WrapAlignment.spaceBetween,//上下
    );
  }
}
