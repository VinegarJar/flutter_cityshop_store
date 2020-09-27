
import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
// import 'package:flutter_cityshop_store/https/httpmanager_method.dart'; 

class HomePages extends StatefulWidget {
  HomePages({Key key}) : super(key: key);

  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {

  @override
  void initState() {
  
    super.initState();
    
    //  HttpUtilMethod manager =  HttpUtilMethod();
    //  HttpUtilMethod manager2 = HttpUtilMethod.instance;


    //  print("-------$manager----------");
    //  print("-------$manager2----------");

  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.orange,  
    appBar: AppBar(
      backgroundColor: Colors.yellow,
          title: Text("首页"),
          centerTitle: true, //标题居中显示
        ),
    body: Text("我是第一个页面"),    
    );
        
  }
}