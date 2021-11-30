import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cityshop_store/common/bloc/login%20/login_bloc.dart';
import 'package:flutter_cityshop_store/pages/login/login_botton.dart';
import 'package:flutter_cityshop_store/pages/login/login_input.dart';
import 'package:flutter_cityshop_store/router/navigator_utils.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _editTextController = new TextEditingController();
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
  void didUpdateWidget(LoginPage oldWidget) {
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

    return BlocProvider(
      create: (BuildContext context) => LoginBloc(),
      child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scaffold(
            backgroundColor: ThemeColors.mainBgColor,
            appBar: AppBar(
              elevation: 0, // 隐藏阴影
              backgroundColor: ThemeColors.mainBgColor,
              title: Text(
                "登录即可申请贷款",
                style: TextStyle(
                    color: Colors.black, fontSize: ScreenUtil().setSp(36)),
              ),
              centerTitle: true,
            ),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  LoginInput(
                    hintText: "请输入手机号",
                    controller: _editTextController,
                    onChanged: (String value) {
                      _inputChanged(value);
                      print('输入框----$value');
                    },
                  ),
                  LoginBotton(onPressed: () {
                    print('LoginBotton----');
                  })
                ]),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.exit_to_app),
              onPressed: () {
                //Navigator.pushReplacementNamed(context, 'index');
                NavigatorUtils.goHome(context);
              },
            ),
          )),
    );
  }
}
