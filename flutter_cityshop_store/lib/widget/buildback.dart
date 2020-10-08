
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildBackActions extends StatelessWidget {

  final String title;

  const BuildBackActions({Key key, this.title = "关闭"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          alignment: Alignment.center,
          child: Text(title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(36))),
        ),
     
    ); 
  }

 

}