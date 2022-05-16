import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';
import 'package:flutter_cityshop_store/common/event/http_error_event.dart';
import 'package:flutter_cityshop_store/https/httpRequest_method.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/onTop_botton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginMsgCodeInput extends StatefulWidget {
  final String hintText;

  final ValueChanged<String> onChanged;

  LoginMsgCodeInput({@required this.hintText, @required this.onChanged});

  @override
  _LoginMsgCodeInputState createState() => _LoginMsgCodeInputState();
}

class _LoginMsgCodeInputState extends State<LoginMsgCodeInput> {
  final TextEditingController _codeTextController = TextEditingController();

  bool sendCodeBtn = false; //判断发送短信按钮是否点击过标志
  bool checkCodeBtn = false; //判断输入框是否有值
  int seconds = 60; //倒计时 10秒
  Timer _timer;

  @override
  void initState() {
    super.initState();
    
    _codeTextController.addListener(_onCodeChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _codeTextController.removeListener(_onCodeChanged);
    _timer?.cancel();
    _timer = null;

  }

  @override
  void didUpdateWidget(LoginMsgCodeInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget != oldWidget) {
      _codeTextController.removeListener(_onCodeChanged);
      _codeTextController.addListener(_onCodeChanged);
    }
  }

  void _onCodeChanged() {
    if (!this.sendCodeBtn) {
      if (_codeTextController.text.length > 0) {
        setState(() {
          this.checkCodeBtn = true;
        });
      } else {
        setState(() {
          this.checkCodeBtn = false;
        });
      }
    }
  }

  //倒计时
  void _showTimer() {
   _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        this.seconds--;
      });
      if (this.seconds == 0) {
       _timer.cancel(); //清除定时器
        setState(() {
          this.sendCodeBtn = false;
          this.checkCodeBtn = true;
        });
      }
    });
  }

  //发送验证码
  sendCode() async {
    if (this.checkCodeBtn) {
      RegExp exp = RegExp(
          r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
      bool matched = exp.hasMatch(_codeTextController.text);
      if (matched) {
        setState(() {
          this.sendCodeBtn = true;
          this.checkCodeBtn = false;
          this.seconds = 60;
          this._showTimer();
        });
        var params = {
          "phoneNum": _codeTextController.text,
          "channelId": "huawei"
        };
        var res = await HttpRequestMethod.instance
            .requestWithMetod(Config.appSmsCode, params);

        var data = res.data ?? {};
        print("发送验证码--${_codeTextController.text}--$matched--$data");

        if (data["code"] == 200) {
          eventBus.fire(new HttpErrorEvent(99, "验证码发送成功"));
        } else {
          eventBus.fire(new HttpErrorEvent(99, "验证码发送失败"));
        }
      } else {
        eventBus.fire(new HttpErrorEvent(99, "输入手机号有误,请重新输入!"));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(600),
      height: ScreenUtil().setWidth(88),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10))),
      child: TextField(
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(11),
        ],
        controller: _codeTextController,
        onChanged: widget.onChanged,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
        obscureText: false, //是否是密码
        textAlign: TextAlign.left, //文本对齐方式
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
          suffixIcon: OnTopBotton(
            callBack: this.sendCode,
            widget: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(208),
              decoration: BoxDecoration(
                  color: this.checkCodeBtn
                      ? ThemeColors.mainColor
                      : ThemeColors.defaultColor,
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setWidth(10))),
              child: Text(this.sendCodeBtn ? "${this.seconds}秒后重新发送" : "获取验证码",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Colors.white,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
