import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cityshop_store/common/bloc/login%20/login_bloc.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef CheckedProtocol = void Function(bool checked);

class LoginAgree extends StatelessWidget {
  final CheckedProtocol onProtocol;
  const LoginAgree({Key key, @required this.onProtocol}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Center(
        child: Container(
            width: ScreenUtil().setWidth(600),
            child: Text.rich(TextSpan(children: [
              WidgetSpan(
                  child: InkWell(
                onTap: () {
                  var checked = (state is LoginChecked && state.checked);
                  BlocProvider.of<LoginBloc>(context)
                      .add(LoginCheckedEvent(checked: !checked));
                  onProtocol(checked);
                },
                child: Icon(
                  (state is LoginChecked && state.checked)
                      ? Icons.check_box_outlined
                      : Icons.check_box_outline_blank,
                  size: ScreenUtil().setSp(38),
                  color: Colors.white,
                  // color: Colors.orange,  Icons.check_box_rounded,
                ),
              )),
              // WidgetSpan(
              //     child: Icon(
              //   Icons.check_box_outlined,
              //   size: ScreenUtil().setSp(38),
              //   color: ThemeColors.mainColor,
              //   // color: Colors.orange,  Icons.check_box_rounded,
              // )),
              TextSpan(
                  text: "我已阅读并同意接受",
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(30))),
              TextSpan(
                text: "《分期借贷用户注册协议》",
                style: TextStyle(
                    color: ThemeColors.loginBgColor,
                    fontSize: ScreenUtil().setSp(30)),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print("点击事件---");
                  },
              ),
              TextSpan(
                  text: "和",
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(30))),
              TextSpan(
                text: "《分期借贷隐私政策》",
                style: TextStyle(
                    color: ThemeColors.loginBgColor,
                    fontSize: ScreenUtil().setSp(30)),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print("分期借贷隐私政策点击事件---");
                  },
              ),
            ]))),
      );
    });
  }
}
