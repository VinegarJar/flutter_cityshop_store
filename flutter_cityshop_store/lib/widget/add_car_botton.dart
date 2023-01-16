import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/provide/common_provider.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddCarBottom extends StatefulWidget {
  final bool goodsDetails;

  AddCarBottom({Key key, this.goodsDetails = false}) : super(key: key);

  @override
  _AddCarBottomState createState() => _AddCarBottomState();
}

class _AddCarBottomState extends State<AddCarBottom> {
  @override
  Widget build(BuildContext context) {
    double allPrice = 0;

    if (widget.goodsDetails) {
      return _goodsDetails();
    } else {
      return _reduceBtn(allPrice);
    }
  }

  Widget _goodsDetails() {
    return Container(
        height: 130.w,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 10.w,
            ),
            Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    print("点击进入购物车");
                    Provider.of<CommonProvider>(context, listen: false)
                        .changeIndex(2);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 90.w,
                    height: 90.w,
                    decoration: BoxDecoration(
                        color: ThemeColors.mainColor,
                        borderRadius: BorderRadius.circular(45.w)),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.shopping_cart,
                      size: 26,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 50.w,
                  top: 10.w,
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Text(
                      '99',
                      style: TextStyle(
                          color: ThemeColors.mainColor,
                          fontSize: ScreenUtil().setSp(16)),
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
                onTap: () async {
                  print("点击加入购物车");
                },
                child: Container(
                  width: 280.w,
                  height: 88.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: ThemeColors.colorTheme,
                      borderRadius: BorderRadius.all(Radius.circular(44.w))),
                  child: Text(
                    '加入购物车',
                    style: TextStyle(
                        color: Colors.white, fontSize: ScreenUtil().setSp(32)),
                  ),
                )),
            InkWell(
                onTap: () async {
                  print("点击马上购买");
                },
                child: Container(
                  width: 280.w,
                  height: 88.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: ThemeColors.mainColor,
                      borderRadius: BorderRadius.all(Radius.circular(44.w))),
                  child: Text(
                    '马上购买',
                    style: TextStyle(
                        color: Colors.white, fontSize: ScreenUtil().setSp(32)),
                  ),
                )),
            SizedBox(
              width: 10.w,
            )
          ],
        ));
  }

  Widget _reduceBtn(double allPrice) {
    return Container(
        height: 100.w,
        margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 30.w),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(50.w)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    print("点击购物车");
                  },
                  child: Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                        color: ThemeColors.mainColor,
                        borderRadius: BorderRadius.circular(50.w)),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.shopping_cart,
                      size: 26,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 55.w,
                  top: 15.w,
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Text(
                      '99',
                      style: TextStyle(
                          color: ThemeColors.mainColor,
                          fontSize: ScreenUtil().setSp(16)),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      allPrice > 0 ? allPrice : '未选购商品',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(32)),
                    ),
                    Text(
                      '另需配送费¥9',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(18)),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
                onTap: () async {
                  // await Provide.value<CartProvide>(context).remove();
                  print("点击马上购买");
                },
                child: allPrice > 0
                    ? Container(
                        width: 200.w,
                        height: 100.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: ThemeColors.mainColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50.w),
                              bottomRight: Radius.circular(50.w),
                            )),
                        child: Text(
                          '去结算',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(32)),
                        ),
                      )
                    : Container(
                        width: 200.w,
                        height: 100.w,
                        decoration: BoxDecoration(
                            color: ThemeColors.color999999,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50.w),
                              bottomRight: Radius.circular(50.w),
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '¥20起送',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(32)),
                            ),
                            Text(
                              '未点必选品',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(18)),
                            ),
                          ],
                        ),
                      )),
          ],
        ));
  }
}
