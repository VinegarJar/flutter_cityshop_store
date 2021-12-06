import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: ScreenUtil().setWidth(245),
          child: Text(
            "用呗",
            style: TextStyle(
                color: ThemeColors.titlesColor,
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtil().setSp(38)),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
          width: ScreenUtil().setWidth(245),
          child: Text(
            "专业贷款 审核更快",
            style: TextStyle(
                color: ThemeColors.titlesColor,
                fontSize: ScreenUtil().setSp(28)),
          ),
        )
      ],
    );
  }
}
