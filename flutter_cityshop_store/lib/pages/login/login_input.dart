import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginInput extends StatefulWidget {


  final String hintText;

  final ValueChanged<String> onChanged;

  final TextStyle textStyle;

  final TextEditingController controller;
  LoginInput(
      {Key key,
      this.hintText,
      this.onChanged,
      this.textStyle,
      this.controller})
      : super(key: key);

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
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
