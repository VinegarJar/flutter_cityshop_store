
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';
import 'package:flutter_cityshop_store/common/event/http_error_event.dart';
import 'package:flutter_cityshop_store/common/local/local_storage.dart';
import 'package:flutter_cityshop_store/https/httpRequest_method.dart';
import 'package:flutter_cityshop_store/provide/user_provider.dart';
import 'package:flutter_cityshop_store/router/navigator_utils.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_cityshop_store/widget/alert.dart';
import 'package:flutter_cityshop_store/widget/onTop_botton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SystemPage extends StatelessWidget {
  const SystemPage({Key key}) : super(key: key);

  List<Widget> _wrapList(context) {
    List tabs = [
      {"title": "隐私政策说明", "path": "privacy"},
      {"title": "知情告知书", "path": "inform"},
      {"title": "个人信息授权使用声明", "path": "information"},
      {"title": "欢迎您注册金用呗账号并使用分期", "path": "agreement"},
    ];

    final List listWidget = tabs.map((results) {
      return InkWell(
          onTap: () async {
            String fileUrl =
                await rootBundle.loadString(Utils.getHtmlPath(results["path"]));
            NavigatorUtils.goToHtmlWebView(context, fileUrl, results["title"]);
          },
          child: Container(
            color: Colors.white,
            width: ScreenUtil().setWidth(750),
            padding: EdgeInsets.symmetric(vertical: 15),
            margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(25)),
                  child: Text(
                    results["title"],
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(32),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                  child: Icon(Icons.arrow_forward_ios_sharp,
                      size: ScreenUtil().setSp(38),
                      color: ThemeColors.titlesColor),
                ),
              ],
            ),
          ));
    }).toList();
    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.mainBgColor,
      appBar: AppBar(
          elevation: 0, // 隐藏阴影
          backgroundColor: ThemeColors.homemainColor,
          title: Text(
            "设置",
            style: TextStyle(
                color: ThemeColors.titlesColor,
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtil().setSp(38)),
          ),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: ThemeColors.titlesColor),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: Column(
        children: [
          Column(mainAxisSize: MainAxisSize.min, children: _wrapList(context)),
          Container(
              margin: EdgeInsets.only(top: ScreenUtil().setWidth(88)),
              child: OnTopBotton(
                callBack: () {
                  Alert.showAlert(
                      widgetContext: context,
                      title: "温馨提示",
                      confirm: "退出",
                      cancel: "取消",
                      content: "您确定要退出吗？",
                      onPressed: () {
                        logOutAction(context);
                        eventBus.fire(new HttpErrorEvent(99, "退出成功"));
                      });
                },
                widget: Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(680),
                  height: ScreenUtil().setWidth(88),
                  decoration: BoxDecoration(
                      color: ThemeColors.homemainColor,
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(10))),
                  child: Text("退出登录",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(32),
                        color: Colors.white,
                      )),
                ),
              ))
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void logOutAction(context) async {
    Provider.of<UserProvider>(context, listen: false).cleanUserInfoCache();
    NavigatorUtils.goLogin(context);
    await HttpRequestMethod.instance.clearAuthorization();
    await LocalStorage.remove(Config.TOKEN_KEY);
    await LocalStorage.remove(Config.USER_INFO);
  }
}
