import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: ScreenUtil().setWidth(128),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 20, top: 8, right: 20, bottom: 8),
              child: Text("用呗",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(38),
                    color: Colors.white,
                  )),
            ),
          ),
          Image(
            image: AssetImage(Utils.getImgPath('login_logo')),
            fit: BoxFit.cover,
            width: ScreenUtil().setWidth(762),
          ),
          SizedBox(
            height: ScreenUtil().setWidth(70),
          )
        ],
      ),
    );
  }
}
