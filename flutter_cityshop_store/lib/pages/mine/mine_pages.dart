import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';
import 'package:flutter_cityshop_store/common/event/http_error_event.dart';
import 'package:flutter_cityshop_store/common/local/local_storage.dart';
import 'package:flutter_cityshop_store/pages/mine/mine_banner.dart';
import 'package:flutter_cityshop_store/pages/mine/mine_head_ground.dart';
import 'package:flutter_cityshop_store/pages/mine/mine_serve.dart';
import 'package:flutter_cityshop_store/router/navigator_utils.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/alert.dart';


class MinePages extends StatefulWidget {
  MinePages({Key key}) : super(key: key);

  @override
  _MinePagesState createState() => _MinePagesState();
}

class _MinePagesState extends State<MinePages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.mainBgColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          children: <Widget>[
          MineHeadGround(),
          MineServe(),
          MineBanner(),        
        ]),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Alert.showAlert(
              widgetContext: context,
              title: "温馨提示",
              confirm: "退出",
              cancel: "取消",
              content: "您确定要退出吗？",
              onPressed: () {
                logOutAction();
                eventBus.fire(new HttpErrorEvent(99, "退出成功"));
              });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void logOutAction() async {
    NavigatorUtils.goLogin(context);
    await LocalStorage.remove(Config.TOKEN_KEY);
    await LocalStorage.remove(Config.USER_INFO);
  }
}
