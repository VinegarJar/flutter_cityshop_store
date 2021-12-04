import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/https/user_dao.dart';
import 'package:flutter_cityshop_store/router/navigator_utils.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomePage extends StatefulWidget {
  static final String name = "/";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool hadInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    new Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {
      UserDao.initUserInfo().then((res) {
        if (res != null && res.result) {
          NavigatorUtils.goHome(context);
        } else {
          NavigatorUtils.goLogin(context);
        }
        return true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
     ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Material(
      child: new Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            new Center(
              child:
                  new Image(image: new AssetImage(Utils.getImgPath('launch_image'))),
            ),
          ],
        ),
      ),
    );
  }
}
