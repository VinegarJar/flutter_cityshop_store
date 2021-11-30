import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cityshop_store/common/bloc/login%20/login_bloc.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginBotton extends StatelessWidget {
  final GestureTapCallback onPressed;
  const LoginBotton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Center(
          child: InkWell(
        onTap: state.phoneNum.isEmpty ? null : onPressed,
        child: Container(
          alignment: Alignment.center,
          width: ScreenUtil().setWidth(660),
          height: ScreenUtil().setWidth(88),
          decoration: BoxDecoration(
              color: state.phoneNum.isEmpty
                  ? ThemeColors.mainColor
                  : Colors.orange,
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(44))),
          child: Text('一键登录',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                color: Colors.black,
              )),
        ),
      ));
    });
  }
}
