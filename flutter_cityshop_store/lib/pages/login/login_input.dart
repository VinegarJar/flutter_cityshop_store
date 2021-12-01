import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cityshop_store/common/bloc/login%20/login_bloc.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginInput extends StatefulWidget {
  final String hintText;

  final ValueChanged<String> onChanged;

  final TextEditingController controller;
  LoginInput(
      {@required this.hintText,
      @required this.controller,
      @required this.onChanged});

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Center(
          child: Container(
              width: ScreenUtil().setWidth(600),
              height: ScreenUtil().setWidth(88),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setWidth(10))),
              child: TextField(
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(11),
                ],
                controller: widget.controller,
                onChanged: widget.onChanged,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                autocorrect: true, //是否自动更正
                autofocus: false, //是否自动对焦
                obscureText: false, //是否是密码
                textAlign: TextAlign.center, //文本对齐方式
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: ScreenUtil().setSp(28),
                    color: Colors.black), //输入文本的样式
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(ScreenUtil().setSp(20)),
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: ThemeColors.titleColor,
                      fontSize: ScreenUtil().setSp(28),
                    ),
                    suffixIcon: (state.phoneNum == "")
                        ? null
                        : IconButton(
                            onPressed: () {
                              widget.controller.clear();
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: ThemeColors.deleteColor,
                              size: ScreenUtil().setSp(28),
                            ))),
              )));
    });
  }
}
