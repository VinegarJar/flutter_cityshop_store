import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginInput extends StatefulWidget {
  final String hintText;

  final ValueChanged<String> onChanged;

  final TextStyle textStyle;

  final TextEditingController controller;
  LoginInput({this.hintText, this.onChanged, this.textStyle, this.controller});

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      autocorrect: true, //是否自动更正
      autofocus: true, //是否自动对焦
      obscureText: false, //是否是密码
      textAlign: TextAlign.left, //文本对齐方式
      style: TextStyle(
          fontSize: ScreenUtil().setSp(32), color: Colors.black), //输入文本的样式
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: ThemeColors.titleColor,
            fontSize: ScreenUtil().setSp(26),
          ),
          suffixIcon: widget.controller.text.isEmpty
              ? null
              : IconButton(
                  onPressed: () {
                    widget.controller.clear();
                  },
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.grey,
                    size: ScreenUtil().setSp(22),
                  ))),
    );
  }
}
