import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginBotton extends StatelessWidget {
  const LoginBotton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: ScreenUtil().setWidth(660),
      height: ScreenUtil().setWidth(88),
      decoration: BoxDecoration(
          color: ThemeColors.mainColor,
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(44))),
    ));
  }
}
