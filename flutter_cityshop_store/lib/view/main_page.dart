import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/widget/appbar.dart';
import 'package:flutter_cityshop_store/http/httpUtil_method.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

   @override
   void initState() { 
     super.initState();
        httpUtil_method.requestGetWithPath("https://www.baidu.com").then((value) {
             
             print("============$value");
        });

   }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:AppBarWidget(title:"首页",canBack: true ).build(context),
       body: Container(
         child: SingleChildScrollView(
           //controller: controller,
           child: Column(
             
           ),
         ),
       ),
    );
  }
}