import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef OnPressedResults = void Function(dynamic result);

class Associator extends StatelessWidget {
  Associator({Key key}) : super(key: key);

  final dataSource = [
    {"title": "黑名单检测", "url": Utils.getImgPath('blacklist')},
    {"title": "下款快", "url": Utils.getImgPath('payments')},
    {"title": "通过率高", "url": Utils.getImgPath('pass')},
    {"title": "急速放款", "url": Utils.getImgPath('rapid')}
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_wrapList(dataSource, context), _checkList(context)],
      ),
    );
  }

  Widget _checkList(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
            vertical: ScreenUtil().setWidth(20)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          InkWell(
              onTap: () {
                print("信用检测------");
              },
              child: Container(
                  width: ScreenUtil().setWidth(340),
                  height: ScreenUtil().setWidth(200),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setWidth(15)),
                    image: DecorationImage(
                      image: AssetImage(
                        Utils.getImgPath('credit'),
                      ),
                      fit: BoxFit.contain,
                    ),
                  ))),
          InkWell(
              onTap: () {
                print("会员专享------");
              },
              child: Container(
                  width: ScreenUtil().setWidth(340),
                  height: ScreenUtil().setWidth(200),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setWidth(15)),
                    image: DecorationImage(
                      image: AssetImage(
                        Utils.getImgPath('associator'),
                      ),
                      fit: BoxFit.contain,
                    ),
                  ))),
        ]));
  }

  Widget _wrapList(List dataSource, BuildContext context) {
    List<Widget> listWidget = dataSource.map((val) {
      return InkWell(
          onTap: () {
            print("专属服务专区---$val---");
          },
          child: Container(
              width: MediaQuery.of(context).size.width / 4 ,
              margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(20)),
              child: Column(children: [
                Image(
                    image: AssetImage(
                      val["url"],
                    ),
                    fit: BoxFit.cover),
                SizedBox(
                  height: ScreenUtil().setWidth(20),
                ),
                Text(
                  val["title"],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: ThemeColors.appliedColor,
                      fontSize: ScreenUtil().setSp(34)),
                ),
                SizedBox(
                  height: ScreenUtil().setWidth(10),
                ),
              ])));
    }).toList();
    return Row(
        mainAxisAlignment: MainAxisAlignment.center, children: listWidget);
  }
}
