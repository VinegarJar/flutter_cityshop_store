import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tage extends StatelessWidget {
  final String titel;
  const Tage({Key key, this.titel = "推荐贷款"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(20),
          vertical: ScreenUtil().setWidth(10)),
      child: Text(titel,
          style: TextStyle(
              color: ThemeColors.titleColor, fontSize: ScreenUtil().setSp(38))),
    );
  }
}
