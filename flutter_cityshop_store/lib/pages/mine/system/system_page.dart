import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cityshop_store/router/navigator_utils.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SystemPage extends StatelessWidget {
  const SystemPage({Key key}) : super(key: key);

  List<Widget> _wrapList(context) {
    List tabs = [
      {"title": "《隐私政策》", "index": 1},
      {"title": "《知情告知书》", "index": 2},
      {"title": "《个人信息授权使用声明》", "index": 3},
      {"title": "《欢迎您注册用呗账号并使用分期》", "index": 4},
    ];

    final List listWidget = tabs.map((results) {
      return InkWell(
          onTap: () async{
      
             String fileUrl = await rootBundle.loadString(Utils.getHtmlPath('agreement'));
             NavigatorUtils.goWebView(context, fileUrl,results["title"]);
             
          },
          child: Container(
              width: ScreenUtil().setWidth(750),
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                results["title"],
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(32),
                    fontWeight: FontWeight.w600),
              )));
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
      body: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: _wrapList(context)),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
