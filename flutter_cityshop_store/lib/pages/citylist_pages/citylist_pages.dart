import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cityshop_store/model/models.dart';
import 'package:flutter_cityshop_store/pages/citylist_pages/citysearch.dart';
import 'package:flutter_cityshop_store/router/routes.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_cityshop_store/widget/buildback.dart';
import 'package:flutter_cityshop_store/widget/loding.dart';
import 'package:flutter_cityshop_store/widget/searchbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lpinyin/lpinyin.dart';

class CityListPages extends StatefulWidget {
  CityListPages({Key key}) : super(key: key);

  @override
  _CityListPagesState createState() => _CityListPagesState();
}

class _CityListPagesState extends State<CityListPages> {
  List<CityModel> cityList = List();
  double susItemHeight = 36;
  String imgFavorite = Utils.getImgPath('ic_favorite');

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      loadData();
    });
  }

  void loadData() async {
    //加载城市列表
    rootBundle.loadString('assets/datas.json').then((value) {
      cityList.clear();
      Map countyMap = json.decode(value);
      List list = countyMap['china'];
      list.forEach((v) {
        cityList.add(CityModel.fromJson(v));
      });
      _handleList(cityList);
    });
  }

  void _handleList(List<CityModel> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp('[A-Z]').hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = '#';
      }
    }
    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(list);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(cityList);

    // add header.
    cityList.insert(
        0,
        CityModel(
            name: 'header',
            tagIndex: imgFavorite)); //index bar support local images.

    setState(() {});
  }

  //火爆专区
  Widget _hotCity(List<CityModel> hotGoodsList) {
    List<Widget> listWidget = hotGoodsList.map((val) {
      return InkWell(
          onTap: () {
            print("火爆专区---$val");
          },
          child: Container(
            width: ScreenUtil().setWidth(200),
            height: ScreenUtil().setHeight(88),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: new Border.all(color: Colors.grey[300], width: 0.5),
                color: Colors.white,
                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(6))),
            child: Text(val.name,
                style: TextStyle(
                    color: ThemeColors.titleColor,
                    fontSize: ScreenUtil().setSp(28))),
          ));
    }).toList();

    return Wrap(
      spacing: ScreenUtil().setWidth(25), //左右
      runSpacing: ScreenUtil().setWidth(20), //上下
      children: listWidget, //加载子组件
      // alignment: WrapAlignment.spaceEvenly, //左右
      //runAlignment: WrapAlignment.spaceBetween,//上下
    );
  }

  //火爆专区
  Widget _buildHeader() {
    List<CityModel> hotCityList = List();
    hotCityList.addAll([
      CityModel(name: "北京市"),
      CityModel(name: "广州市"),
      CityModel(name: "成都市"),
      CityModel(name: "深圳市"),
      CityModel(name: "杭州市"),
      CityModel(name: "武汉市"),
    ]);

    return Container(
        child: Column(
      children: [
        ListTile(
          title: Text("热门城市",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(32))),
        ),
        _hotCity(hotCityList),
        SizedBox(
          height: ScreenUtil().setHeight(20),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ThemeColors.mainColor,
          leading: null,
          actions: [
            BuildBackActions(
              title: "取消",
            )
          ],
          titleSpacing: 8,
          title: SearchBar(
            searchFieldLabel: "城市搜索",
            onTapSearch: () {
              print("onTapSearch");
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>  CitySearchResult(cityList:cityList),
                ),
              );
            },
          ),
          centerTitle: true, //标题居中显示
        ),
        body: Column(
          children: [
            ListTile(
                title: Text("当前城市位置",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(32))),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(CupertinoIcons.location_solid,
                        size: 20, color: ThemeColors.colorRed),
                    Text(" 成都市"),
                  ],
                )),
            Divider(
              height: .0,
            ),
            _citylist(cityList),
          ],
        ));
  }

  Widget _citylist(List<CityModel> cityList) {
    if (cityList.length > 0) {
      return Expanded(
        child: AzListView(
          data: cityList,
          itemCount: cityList.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) return _buildHeader();
            CityModel model = cityList[index];
            return Utils.getListItem(context, model, susHeight: susItemHeight);
          },
          susItemHeight: susItemHeight,
          susItemBuilder: (BuildContext context, int index) {
            CityModel model = cityList[index];
            String tag = model.getSuspensionTag();
            if (imgFavorite == tag) {
              return Container();
            }
            return Utils.getSusItem(context, tag, susHeight: susItemHeight);
          },
          indexBarData: SuspensionUtil.getTagIndexList(cityList),
          indexBarOptions: IndexBarOptions(
            needRebuild: true,
            color: Colors.transparent,
            downColor: Color(0xFFEEEEEE),
            localImages: [imgFavorite], //local images.
          ),
        ),
      );
    } else {
      return Expanded(child: LoadingWidget());
    }
  }
}
