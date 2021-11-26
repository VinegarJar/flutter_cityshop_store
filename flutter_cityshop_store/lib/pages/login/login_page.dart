import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage() {
    print("LoginPage-构造函数被调用");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登陆页'),
      ),
      body: Center(
        child: Text('请登录'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        onPressed: () {
          Navigator.pushReplacementNamed(context, 'index');
        },
      ),
    );
  }
}
