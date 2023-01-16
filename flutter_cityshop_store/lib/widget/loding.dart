import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              strokeWidth: 1.5,
              valueColor:  AlwaysStoppedAnimation(ThemeColors.mainColor),
            ),
            SizedBox(width: 10),
            Text(
              '正在加载..',
              style: TextStyle(
                        color: ThemeColors.titleColor,
                        fontSize: ScreenUtil()
                            .setSp(24, allowFontScalingSelf: true)),
            )
          ],
        ),
      ),
    );
  }
}
