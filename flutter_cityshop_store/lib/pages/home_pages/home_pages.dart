
import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/https/httpManager_method.dart';
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
    
     HttpManagerMethod manager =  HttpManagerMethod();
     HttpManagerMethod manager2 = HttpManagerMethod.instance;
    
     Text  tset = Text(""); 


     print("-----单利一初始化调用--$manager----------");
     print("-----单利二初始化调用--$manager2----------");


     print("-----单利一获取调用--$tset----------");
     print("-----单利二获取调用--${manager2.getInstan()}----------");
    


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