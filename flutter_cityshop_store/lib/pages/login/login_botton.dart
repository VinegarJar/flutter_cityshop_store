import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cityshop_store/common/bloc/login%20/login_bloc.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/onTop_botton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginBotton extends StatelessWidget {
  final GestureTapCallback onPressed;
  const LoginBotton({@required this.onPressed});

  final title = "一键登录";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Center(
          child: OnTopBotton(
        callBack: onPressed,
        // callBack: ((state.phoneNum.length == 11) && state.phoneNum != "")?onPressed:null,
        title: title,
        widget: Container(
          alignment: Alignment.center,
          width: ScreenUtil().setWidth(600),
          height: ScreenUtil().setWidth(88),
          decoration: BoxDecoration(
              color: (state.phoneNum != "")
                  ? ThemeColors.mainColor
                  : ThemeColors.defaultColor,
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10))),
          child: Text(title,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(32),
                color: Colors.white,
              )),
        ),
      ));
    });
  }
}
