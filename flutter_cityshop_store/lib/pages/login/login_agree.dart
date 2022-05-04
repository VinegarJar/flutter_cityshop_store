import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/router/navigator_utils.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef CheckedProtocol = void Function(bool checked);

class LoginAgree extends StatefulWidget {
  final CheckedProtocol onProtocol;
  const LoginAgree({Key key, @required this.onProtocol}) : super(key: key);

  @override
  _LoginAgreeState createState() => _LoginAgreeState();
}

class _LoginAgreeState extends State<LoginAgree> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: ScreenUtil().setWidth(600),
          child: Text.rich(TextSpan(children: [
            WidgetSpan(
                child: InkWell(
              onTap: () {
                this.setState(() {
                  checked = !checked;
                });
                widget.onProtocol(checked);
              },
              child: Icon(
                (checked)
                    ? Icons.check_box_outlined
                    : Icons.check_box_outline_blank,
                size: ScreenUtil().setSp(38),
                color: checked ? ThemeColors.mainColor : Colors.white,
              ),
            )),
            TextSpan(
                text: "我已阅读并同意接受",
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(30))),
            TextSpan(
              text: "《用呗分期用户注册协议》",
              style: TextStyle(
                  color: ThemeColors.loginBgColor,
                  fontSize: ScreenUtil().setSp(30)),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                   NavigatorUtils.goWebView(context, "http://welcome.xingdiandeng.com/", "用呗分期用户注册协议");
                },
            ),
            TextSpan(
                text: "和",
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(30))),
            TextSpan(
              text: "《用呗分期隐私政策》",
              style: TextStyle(
                  color: ThemeColors.loginBgColor,
                  fontSize: ScreenUtil().setSp(30)),
              recognizer: TapGestureRecognizer()
                ..onTap = () async{
                  print("用呗隐私政策点击事件---");
                  NavigatorUtils.goWebView(context, "http://yinsi.xingdiandeng.com/", "用呗分期隐私政策");
                },
            ),
          ]))),
    );
  }
}
