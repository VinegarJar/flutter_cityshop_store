import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/model/userinfo.dart';
import 'package:flutter_cityshop_store/provide/user_provider.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_cityshop_store/widget/associator.dart';
import 'package:flutter_cityshop_store/widget/tag.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class AssociatorPages extends StatefulWidget {
  AssociatorPages({Key key}) : super(key: key);

  @override
  _AssociatorPagesState createState() => _AssociatorPagesState();
}

class _AssociatorPagesState extends State<AssociatorPages> {
  Widget _userInfo(UserInfo userInfo) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(30)),
        color: Colors.white,
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(
                    bottom: ScreenUtil().setWidth(15),
                    left: ScreenUtil().setWidth(40),
                    right: ScreenUtil().setWidth(20)),
                width: ScreenUtil().setWidth(120),
                height: ScreenUtil().setWidth(120),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage(Utils.getImgPath('head_image')),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().setWidth(60))))),
            Container(
              height: ScreenUtil().setWidth(120),
              margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userInfo?.nickName ?? "未实名认证",
                      style: TextStyle(
                          color: ThemeColors.titlesColor,
                          fontSize: ScreenUtil().setSp(32)),
                      textAlign: TextAlign.left),
                  Text("有效期至:2021-12-13",
                      style: TextStyle(
                          color: ThemeColors.titlesColor,
                          fontSize: ScreenUtil().setSp(30)),
                      textAlign: TextAlign.left),
                ],
              ),
            ),
          ],
        ));
  }

   Widget _associatorCheck() {
     return Container(
        color: Colors.white,
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
         children: [
             Tage(titel: "会员精选"),
         ],
       ),
     );
   }

  Widget build(BuildContext context) {
    UserInfo userInfo = Provider.of<UserProvider>(context).userInfo;
    return Scaffold(
        backgroundColor: ThemeColors.mainBgColor,
        appBar: AppBar(
            elevation: 0, // 隐藏阴影
            backgroundColor: ThemeColors.homemainColor,
            title: Text(
              "我的会员",
              style: TextStyle(
                  color: ThemeColors.titlesColor,
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenUtil().setSp(38)),
            ),
            centerTitle: true,
            leading: IconButton(
                icon:
                    Icon(Icons.arrow_back_ios, color: ThemeColors.titlesColor),
                onPressed: () {
                  Navigator.pop(context);
                })),
        body: ListView(
          children: [
            _userInfo(userInfo),
            Associator(),
            SizedBox(height: ScreenUtil().setWidth(20),),
            _associatorCheck(),
          ],
        )

        //  SingleChildScrollView(
        //   child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        //     _userInfo(userInfo),

        //   ]),
        // ),

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
