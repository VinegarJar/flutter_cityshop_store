
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/common/event/http_error_event.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VipPages extends StatefulWidget {
  VipPages({Key key}) : super(key: key);

  @override
  _VipPagesState createState() => _VipPagesState();
}

class _VipPagesState extends State<VipPages> {
 
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Fluttertoast.showToast(
        msg: "该产品为会员专属产品,开通后即可解锁",
        fontSize: ScreenUtil().setSp(32),
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG,
        );  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColors.mainBgColor,
        appBar: AppBar(
            elevation: 0, // 隐藏阴影
            backgroundColor: ThemeColors.mainBgColor,
            title: Text(
              "超级VIP",
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
            // _userInfo(userInfo),
            // Associator(),
            // SizedBox(
            //   height: ScreenUtil().setWidth(20),
            // ),
            // _associatorCheck(),
          ],
        ));
  }
}
