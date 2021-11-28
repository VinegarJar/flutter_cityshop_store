import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/router/navigator_utils.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController userController = new TextEditingController();

  LoginPage() {
    print("LoginPage-构造函数被调用");
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child:Scaffold(
         backgroundColor: ThemeColors.loginBgColor,
      // appBar: AppBar(
      //   backgroundColor: ThemeColors.loginBgColor,
      //   title: Text('登陆页'),
      // ),
      body: Center(
        child: Text('请登录'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        onPressed: () {
          //Navigator.pushReplacementNamed(context, 'index');
          NavigatorUtils.goHome(context);
        },
      ),
    ))
    ;
  }


  Widget _wrapList(BuildContext context) {

  }


}
