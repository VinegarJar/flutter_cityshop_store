import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/model/goodsinfo.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WrapList extends StatelessWidget {
  final List<GoodsList> hotGoodsList;
  WrapList({this.hotGoodsList});

  @override
  Widget build(BuildContext context) {
    return _wrapList(hotGoodsList, context);
  }

  //火爆专区
  Widget _wrapList(List<GoodsList> hotGoodsList, BuildContext context) {
    const url =
        "http://t00img.yangkeduo.com/goods/images/2021-05-20/919fb6a6d20ccff1b030c5fabbb6be41.jpeg";

    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
            onTap: () {
              print("火爆专区---$val---");

              // 触摸收起键盘FocusScope.of(context).requestFocus(FocusNode());
              // Routes.navigateTo(
              //   context,
              //   Routes.details,
              //   params: {
              //     "goodsName": val.goodsName,
              //     "shortName": val.shortName,
              //     "marketPrice": val.marketPrice.toString(),
              //     "price": val.group["price"].toString(),
              //     "salesTip": val.salesTip,
              //     "imageUrl": val.imageUrl,
              //     "thumbUrl": val.thumbUrl,
              //     "hdThumbUrl": val.hdThumbUrl,
              //     "hdUrl": val.hdUrl,
              //   },
              //   transition: TransitionType.cupertinoFullScreenDialog,
              // );
            },
            child: Container(
                width: ScreenUtil().setWidth(330),
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(30),
                    top: ScreenUtil().setWidth(20)),
                decoration: BoxDecoration(
                    border: new Border.all(
                        color: ThemeColors.colorF6F6F8, width: 0.5),
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setHeight(12))),
                child: Column(children: [
                  SizedBox(
                    height: 5,
                  ),
                  Image.network(val.thumbUrl ?? url,
                      width: ScreenUtil().setWidth(330),
                      height: ScreenUtil().setWidth(330 * 0.7),
                      fit: BoxFit.contain),
                  Container(
                    margin:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    child: Text(
                      val.goodsName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: ThemeColors.titleColor,
                          fontSize: ScreenUtil().setSp(26)),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              "￥${val.group["price"].toString().substring(0, 2)}",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil().setSp(32))),
                          Text(
                            "￥${val.marketPrice.toString().substring(0, 2)}",
                            style: TextStyle(
                                color: Colors.black26,
                                fontSize: ScreenUtil().setSp(22),
                                decoration:
                                    TextDecoration.lineThrough), //价格横线显示样式
                          )
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Text("火热抢购中 " + val.salesTip,
                              style: TextStyle(
                                  color: ThemeColors.titleColor,
                                  fontSize: ScreenUtil().setSp(24)))
                        ],
                      )),
                ])));
      }).toList();

      return Wrap(
        // spacing: 7.5, //左右
        runSpacing: ScreenUtil().setWidth(10), //上下
        children: listWidget, //加载子组件
      );
    } else {
      return Text(' ');
    }
  }
}
