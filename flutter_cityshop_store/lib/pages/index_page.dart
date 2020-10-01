import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/pages/car_pages/car_pages.dart';
import 'package:flutter_cityshop_store/pages/catergory_pages/catergory_pages.dart';
import 'package:flutter_cityshop_store/pages/home_pages/home_pages.dart';
import 'package:flutter_cityshop_store/pages/mine_pages/mine_pages.dart';
import 'package:flutter_cityshop_store/provide/common_provider.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart'; //屏幕适配


class IndexPages extends StatelessWidget {

  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home), title: Text('首页')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text('分类')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: Text('购物车')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text('会员中心')),
  ];

  final List<Widget> tabBodies = [
    HomePages(),
    CaterGoryPages(),
    CarPages(),
    MinePages()
  ];


  @override
  Widget build(BuildContext context) {
    //初始化屏幕适配组件
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    int currentIndex = Provider.of<CommonProvider>(context).currentIndex;
   

    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: ThemeColors.mainColor,
          currentIndex:currentIndex,
          items: bottomTabs,
          onTap: (index) {
            Provider.of<CommonProvider>(context, listen: false)
                .changeIndex(index);
        
          },
        ),
        body: IndexedStack(index:currentIndex, children: tabBodies),
      );
  }
}
