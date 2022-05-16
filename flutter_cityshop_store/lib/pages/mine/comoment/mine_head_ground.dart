import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/model/userinfo.dart';
import 'package:flutter_cityshop_store/provide/user_provider.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_cityshop_store/widget/onTop_botton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MineHeadGround extends StatefulWidget {
  final VoidCallback callBack;
  final VoidCallback onPressed;
  MineHeadGround({
    Key key,
    this.callBack,
    this.onPressed,
  }) : super(key: key);

  @override
  _MineHeadGroundState createState() => _MineHeadGroundState();
}

class _MineHeadGroundState extends State<MineHeadGround> {
  mobile(phoneNumber) {
    return phoneNumber.replaceFirst(new RegExp(r'\d{4}'), '****', 3);
  }

  Widget _userInfo(UserInfo userInfo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
                margin: EdgeInsets.only(
                    bottom: ScreenUtil().setWidth(35),
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
              margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(35)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userInfo?.nickName ?? "未实名认证",
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
                onTap: () {
                  // print("专属服务专区---$val---");
                  widget.onPressed();
                },
                child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(40)),
                    child: Image(
                        width: ScreenUtil().setWidth(50),
                        height: ScreenUtil().setWidth(50),
                        image: AssetImage(Utils.getImgPath('set')),
                        fit: BoxFit.contain)))
          ],
        )
      ],
    );
  }

  Widget _userInfoVIP(UserInfo userInfo) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(32)),
      height: ScreenUtil().setWidth(100),
    );
    bool isVIP = Provider.of<UserProvider>(context, listen: false).isVIP;
    var radius = ScreenUtil().setWidth(25);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(32)),
      height: ScreenUtil().setWidth(100),
      decoration: BoxDecoration(
          color: ThemeColors.vipBgColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: radius),
            child: Row(
              children: [
                Text(
                  "VIP会员",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ThemeColors.viptitleColor,
                      fontSize: ScreenUtil().setSp(36)),
                ),
                SizedBox(width: radius),
                Text(
                  "尊享拒就赔特权", //
                  style: TextStyle(
                      color: ThemeColors.vipsubtitleColor,
                      fontSize: ScreenUtil().setSp(30)),
                ),
              ],
            ),
          ),
          OnTopBotton(
            callBack: widget.callBack,
            title: "立即加入",
            widget: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: radius),
              padding: EdgeInsets.symmetric(horizontal: radius),
              height: ScreenUtil().setWidth(66),
              decoration: BoxDecoration(
                  color: ThemeColors.homemainColor,
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setWidth(44))),
              child: Text(isVIP ? "我的会员" : "立即加入",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: ThemeColors.appliedColor,
                  )),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserInfo userInfo = Provider.of<UserProvider>(context).userInfo;

    return Container(
      height: ScreenUtil().setWidth(365),
      color: ThemeColors.homemainColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [_userInfo(userInfo), _userInfoVIP(userInfo)],
      ),
    );
  }
}
