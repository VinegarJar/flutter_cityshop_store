import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


//LoadingWidget loding.dart

typedef OnTapSearch = void Function();
typedef OnOpenCamera = void Function();


class SearchBar extends StatelessWidget {

  final String searchFieldLabel;
  final OnTapSearch   onTapSearch;
  final OnOpenCamera   openCamera; 
  final bool  isOpenCamera;


  const SearchBar({Key key,
                  this.searchFieldLabel = "热爱就现在 万店千城品牌日", 
                  this.onTapSearch, 
                  this.openCamera, 
                  this.isOpenCamera = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0, right: 0),
      height: ScreenUtil().setHeight(66),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ScreenUtil().setHeight(12))),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(

              child: Icon(CupertinoIcons.search,
                  size: 20, color: ThemeColors.titleColor),
              padding: EdgeInsets.all(5),
            ),
            Expanded(
              child:InkWell(
              onTap:(){
                onTapSearch();
              },
              child: Text(searchFieldLabel,
                    style: TextStyle(
                        color: ThemeColors.titleColor,
                        fontSize: ScreenUtil().setSp(26)))),
            ),
            isOpenCamera?    
            InkWell(
              onTap:(){
                openCamera();
              },
              child: Container(
                child: Icon(CupertinoIcons.photo_camera,
                    size: 20, color: ThemeColors.titleColor),
                padding: EdgeInsets.all(5),
              ),
            ):Container()
          ])
    );
  }
}
