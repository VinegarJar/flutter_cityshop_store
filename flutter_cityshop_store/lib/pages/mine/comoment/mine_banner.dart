import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MineBanner extends StatelessWidget {
  const MineBanner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
          highlightColor: Colors.transparent,
        onTap: () {
          print("---防止诈骗---");
        },
        child: Container(
          // color: Colors.red,
          // margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(20)),
          width: ScreenUtil().setWidth(762),
          height: ScreenUtil().setWidth(170),
          child: Image(
           image: AssetImage(
                Utils.getImgPath('mine_banner'),
              ),
            fit:BoxFit.cover
          )
        ));
  }
}
