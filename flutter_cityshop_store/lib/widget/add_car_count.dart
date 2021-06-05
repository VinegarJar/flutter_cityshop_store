import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCarCount extends StatefulWidget {
  final Function(int count) addPressed;
  final Function(int count) reducePressed;
  AddCarCount({Key key, this.addPressed, this.reducePressed,}) : super(key: key);

  @override
  _AddCarCountState createState() => _AddCarCountState();
}

class _AddCarCountState extends State<AddCarCount> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (count == 0) {
      return  InkWell(
         onTap: () {
          setState(() {
             count++;
           });
           widget.addPressed(count);
        },
        child:Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            width: 60.w,
            height: 60.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ThemeColors.mainColor,
                borderRadius: BorderRadius.circular(30.w)),
            child: Text('+',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(32),
                  color: Colors.white,
                )),
          ),
        )
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: 20.w),
        height: 60.w,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: ThemeColors.mainColor),
            borderRadius: BorderRadius.circular(30.w)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _reduceBtn(),
            _countArea(),
            _addBtn(),
          ],
        ),

      );
    }
  }

  // 减少按钮
  Widget _reduceBtn() {
    return InkWell(
      onTap: () {
         print("减少按钮");
         if(count>0){
           setState(() {
             count--;
           });
         }
         widget.reducePressed(count);
      },
      child: Container(
        width: 60.w,
        height: 60.w,
        alignment: Alignment.center,
        child: Text('一',
            style: TextStyle(color: ThemeColors.mainColor, fontSize: 15)),
      ),
    );
  }

  //添加按钮
  Widget _addBtn() {
    return InkWell(
      onTap: () {
        print("添加按钮");
         setState(() {
             count++;
           });
         widget.addPressed(count);  
      },
      child: Container(
        width: 60.w,
        height: 60.w,
        alignment: Alignment.center,
        child: Text('+',
        style: TextStyle(color: ThemeColors.mainColor, fontSize: 18)),
      ),
    );
  }

  //中间数量显示区域
  Widget _countArea() {
    return Container(
      margin: EdgeInsets.only(left: 0, right: 0),
      height: 60.w,
      alignment: Alignment.center,
      child: Text('$count',
      style: TextStyle(color: ThemeColors.mainColor, fontSize: 18)),
    );
  }
}
