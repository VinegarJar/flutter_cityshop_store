import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/model/userinfo.dart';
import 'package:flutter_cityshop_store/provide/user_provider.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MineHeadGround extends StatefulWidget {
  MineHeadGround({Key key}) : super(key: key);

  @override
  _MineHeadGroundState createState() => _MineHeadGroundState();
}

class _MineHeadGroundState extends State<MineHeadGround> {

  
  
  mobile(phoneNumber){
    return phoneNumber.replaceFirst(new RegExp(r'\d{4}'), '****', 3);
  }


  @override
  Widget build(BuildContext context) {
  UserInfo userInfo = Provider.of<UserProvider>(context).userInfo;
    return Container(
      height: ScreenUtil().setWidth(325),
      color: ThemeColors.homemainColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              margin: EdgeInsets.only(
                  bottom: ScreenUtil().setWidth(80),
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
            margin: EdgeInsets.only(
              bottom: ScreenUtil().setWidth(80),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                 userInfo?.nickName?? "未实名认证",
                  style: TextStyle(
                      color: ThemeColors.titlesColor,
                      fontSize: ScreenUtil().setSp(32)),
                ),
           
                 Text(
                  mobile(userInfo.phoneNum),
                  style: TextStyle(
                      color: ThemeColors.titlesColor,
                      fontSize: ScreenUtil().setSp(30)),
                ), 
              ],
            ),
          ),
        ],
      ),
    );
  }
}
