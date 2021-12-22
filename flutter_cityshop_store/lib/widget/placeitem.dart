import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaceItem extends StatelessWidget {
  const PlaceItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(15),
          vertical: ScreenUtil().setWidth(10)),
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(20),
          vertical: ScreenUtil().setWidth(20)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: ScreenUtil().setWidth(40),
                height: ScreenUtil().setHeight(40),
                decoration: BoxDecoration(
                    color: ThemeColors.mainBgColor,
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setWidth(5))),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setHeight(10)),
                width: ScreenUtil().setWidth(80),
                height: ScreenUtil().setHeight(35),
                color: ThemeColors.mainBgColor,
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(5)),
                width: ScreenUtil().setWidth(50),
                height: ScreenUtil().setHeight(35),
                color: ThemeColors.mainBgColor,
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(5)),
                width: ScreenUtil().setWidth(50),
                height: ScreenUtil().setHeight(35),
                color: ThemeColors.mainBgColor,
              ),
            ],
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setHeight(20)),
                    height: ScreenUtil().setWidth(60),
                    width: ScreenUtil().setWidth(180),
                    decoration: BoxDecoration(
                        color: ThemeColors.mainBgColor,
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(10))),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setHeight(20)),
                    height: ScreenUtil().setWidth(60),
                    width: ScreenUtil().setWidth(180),
                    decoration: BoxDecoration(
                        color: ThemeColors.mainBgColor,
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(10))),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setHeight(20)),
                  ),
                  Container(
                    height: ScreenUtil().setWidth(60),
                    width: ScreenUtil().setWidth(160),
                    decoration: BoxDecoration(
                        color: ThemeColors.mainBgColor,
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(10))),
                  ),
                ],
              )),
          Container(
            width: ScreenUtil().setWidth(60),
            height: ScreenUtil().setHeight(35),
            color: ThemeColors.mainBgColor,
          ),
        ],
      ),
    );
  }
}
