import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/provide/common_provider.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'catergory/catergory_pages.dart';
import 'home/home_pages.dart';
import 'mine/mine_pages.dart';

class IndexPages extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: '首页'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.news_solid), label: '新口子'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), label: '会员中心'),
  ];

  final List<Widget> tabBodies = [
    HomePages(),
    CaterGoryPages(),
    MinePages(),
  ];

  @override
  Widget build(BuildContext context) {
    //初始化屏幕适配组件
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    int currentIndex = Provider.of<CommonProvider>(context).currentIndex;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: ThemeColors.mainColor,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          Provider.of<CommonProvider>(context, listen: false)
              .changeIndex(index);
        },
      ),
      body: IndexedStack(index: currentIndex, children: tabBodies),
    );
  }
}
