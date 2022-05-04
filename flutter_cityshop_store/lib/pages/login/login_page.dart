import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cityshop_store/common/bloc/login%20/login_bloc.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';
import 'package:flutter_cityshop_store/common/event/http_error_event.dart';
import 'package:flutter_cityshop_store/common/local/local_storage.dart';
import 'package:flutter_cityshop_store/https/httpRequest_method.dart';
import 'package:flutter_cityshop_store/model/userinfo.dart';
import 'package:flutter_cityshop_store/pages/login/login_agree.dart';
import 'package:flutter_cityshop_store/pages/login/login_botton.dart';
import 'package:flutter_cityshop_store/pages/login/login_input.dart';
import 'package:flutter_cityshop_store/pages/login/login_logo.dart';
import 'package:flutter_cityshop_store/provide/user_provider.dart';
import 'package:flutter_cityshop_store/router/navigator_utils.dart';
import 'package:flutter_cityshop_store/store_app.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_cityshop_store/widget/alert.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static final String name = "login";
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
  bool _checked = false;

  void loadPolicySheet() async {
    final policy = await LocalStorage.get("policy");
    if (policy != "1") {
      BuildContext context = navigatorKey.currentState.overlay.context;
      Alert.showPolicySheet(context: context, onPressed: () {});
    }
  }

  @override
  void initState() {
    super.initState();
    loadPolicySheet();
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
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
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
             final policy = await LocalStorage.get("policy");
          if (policy != "1") {
            BuildContext context = navigatorKey.currentState.overlay.context;
            Alert.showPolicySheet(context: context, onPressed: () {});
          }else{
                _loginRequest();
          }

          }),
          SizedBox(height: ScreenUtil().setWidth(35)),
          LoginAgree(
            onProtocol: (bool checked) {
              print('是否勾选----$checked');
              _checked = checked;
            },
          ),
        ]),
      ))),
    );
  }

  void _loginRequest() async {
    if (!_checked) {
      return eventBus.fire(new HttpErrorEvent(99, "请勾选我已阅读并同意接受协议"));
    }
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    bool matched = exp.hasMatch(_phoneNum);
    if (matched) {
      await EasyLoading.show(
        status: '登陆中...',
        maskType: EasyLoadingMaskType.black,
      );
      var params = {"phoneNum": _phoneNum, "channelId": "vivo"};
      if (Platform.isAndroid) {
        params['androidVisited'] = "1";
      } else {
        params['iosVisited'] = "1";
      }

      var res = await HttpRequestMethod.instance
          .requestWithMetod(Config.loginUrl, params);
      if (res.result) {
        getUserInfo();
        _inputChanged("");
      }
    } else {
      eventBus.fire(new HttpErrorEvent(99, "输入手机号有误,请重新输入!"));
    }
  }

  getUserInfo() async {
    var params = {"phoneNum": _phoneNum};
    var res = await HttpRequestMethod.instance
        .requestWithMetod(Config.userInfo, params);
    //  print('获取用户信息----res----${res.data}');

    UserInfo user = UserInfo.fromJson(res.data);
    print('获取用户信息----user----${user.realNameVerify}');
    print('获取用户nickName----user----${user.nickName}');
    Provider.of<UserProvider>(context, listen: false).savaUserInfoCache(user);
    LocalStorage.save(Config.USER_INFO, json.encode(user.toJson()));
    LocalStorage.save(Config.TOKEN_KEY, user.phoneNum);
    LocalStorage.save(Config.USER_VIP, user.vipLevel.toString());
    EasyLoading.dismiss();
    NavigatorUtils.goHome(context);
  }
}
