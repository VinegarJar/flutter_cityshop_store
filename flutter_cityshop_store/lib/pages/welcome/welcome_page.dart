import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/common/local/local_storage.dart';
import 'package:flutter_cityshop_store/https/user_dao.dart';
import 'package:flutter_cityshop_store/provide/user_provider.dart';
import 'package:flutter_cityshop_store/router/navigator_utils.dart';
import 'package:flutter_cityshop_store/store_app.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_cityshop_store/widget/alert.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  static final String name = "/";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  void loadPolicySheet() async {
    final policy = await LocalStorage.get("policy");
    if (policy == "1") {
      loadJumpPage();
    } else {
      // String fileUrl =
      //     await rootBundle.loadString(Utils.getHtmlPath('privacy'));
      BuildContext context = navigatorKey.currentState.overlay.context;
      Alert.showPolicySheet(
          url: "http://yinsi.xingdiandeng.com",
          context: context,
          onPressed: () {
            NavigatorUtils.goLogin(context);
          });
    }
  }

  void loadJumpPage() async {
    new Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {
      UserDao.initUserInfo().then((res) {
        if (res != null && res.result) {
          Provider.of<UserProvider>(context, listen: false)
              .savaUserInfoCache(res.data);
          NavigatorUtils.goHome(context);
        } else {
          NavigatorUtils.goLogin(context);
        }
        return true;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadPolicySheet();
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
              child: new Image(
                  image: new AssetImage(Utils.getImgPath('launch_image'))),
            ),
          ],
        ),
      ),
    );
  }
}
