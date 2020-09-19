import 'package:flutter/material.dart';

class AppBarWidget  {
  
  final String title;
  final bool  canBack;

  AppBarWidget({this.title = "标题", this.canBack = true});
   
  PreferredSizeWidget  build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true, //标题居中显示
      automaticallyImplyLeading: canBack,
    );
  }  


 
}