import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cityshop_store/common/bloc/login%20/login_bloc.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';
import 'package:flutter_cityshop_store/common/local/local_storage.dart';
import 'package:flutter_cityshop_store/https/httpRequest_method.dart';
import 'package:flutter_cityshop_store/https/result_data.dart';
import 'package:flutter_cityshop_store/pages/login/login_botton.dart';
import 'package:flutter_cityshop_store/pages/login/login_input.dart';
import 'package:flutter_cityshop_store/pages/login/login_logo.dart';
import 'package:flutter_cityshop_store/router/navigator_utils.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_cityshop_store/router/navigator_utils.dart';
// import 'package:flutter_cityshop_store/utils/themecolors.dart';
// import 'package:flutter_cityshop_store/pages/login/login_botton.dart';
// import 'dart:ui';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginBloc(),
      child: LoginHomePage(),
    );
  }
}

class LoginHomePage extends StatefulWidget {
  LoginHomePage({Key key}) : super(key: key);

  @override
  _LoginHomePageState createState() => _LoginHomePageState();
}

class _LoginHomePageState extends State<LoginHomePage> {
  final TextEditingController _editTextController = TextEditingController();
  // ignore: unused_field
  String _phoneNum = "";

  @override
  void initState() {
    super.initState();
    _editTextController.addListener(_onQueryChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _editTextController.removeListener(_onQueryChanged);
  }

  @override
  void didUpdateWidget(LoginHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget != oldWidget) {
      _editTextController.removeListener(_onQueryChanged);
      _editTextController.addListener(_onQueryChanged);
    }
  }

  void _onQueryChanged() {
    _inputChanged(_editTextController.text);
  }

  void _inputChanged(String text) {
    _phoneNum = text;
    BlocProvider.of<LoginBloc>(context).add(LoginChangeEvent(phoneNum: text));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
          body: SingleChildScrollView(
              child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Utils.getImgPath('login_background'),
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              LoginLogo(),
              LoginInput(
                hintText: "请输入手机号",
                controller: _editTextController,
                onChanged: (String value) {
                  _inputChanged(value);
                },
              ),
              SizedBox(height: ScreenUtil().setWidth(35)),
              LoginBotton(onPressed: () async {
                print('LoginBotton----');
                _loginRequest();
              })
            ]),
      ))),
    );
  }

  void _loginRequest() async {
    var params = {"phoneNum": _phoneNum, "channelId": "vivo"};
    if (Platform.isAndroid) {
      params['androidVisited'] = "1";
    } else {
      params['iosVisited'] = "1";
    }

    ResultData res = await HttpRequestMethod.instance
        .requestWithMetod(Config.loginUrl, params);
    if (res.result) {
      var dict = res.data;
      var token;
      if (dict["phoneNum"] != null) {
        token = dict["phoneNum"];
      }
      print("获取tock---$token");
      _inputChanged("");
      _saveToken(token);
    }
  }

  void _saveToken(token) async {
    await LocalStorage.save(Config.TOKEN_KEY, token);
    NavigatorUtils.goHome(context);
  }
}
