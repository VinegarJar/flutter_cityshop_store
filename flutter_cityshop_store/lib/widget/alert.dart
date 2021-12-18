import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_cityshop_store/widget/onTop_botton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Alert {
  static showAlert({
    @required BuildContext widgetContext,
    @required String title,
    @required String confirm,
    @required String cancel,
    String content = "",
    @required Function() onPressed,
  }) {
    showCupertinoDialog(
      context: widgetContext,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              child: Text(cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(confirm),
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop();
                onPressed();
              },
            ),
          ],
        );
      },
    );
  }

  static showDialogSheet({
    @required BuildContext context,
    @required Function(Map<String, dynamic> result) onPressed,
  }) async {
    await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: ScreenUtil().setWidth(600),
            height: ScreenUtil().setWidth(580),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(40))),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setWidth(20)),
                  child: Text(
                    "实名认证",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(36),
                      color: ThemeColors.homemainColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  "完成实名认证,提升借款额度",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    color: ThemeColors.titleColor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(30),
                      vertical: ScreenUtil().setWidth(60)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image(
                              width: ScreenUtil().setWidth(50),
                              height: ScreenUtil().setWidth(50),
                              image: AssetImage(
                                Utils.getImgPath('name'),
                              ),
                              fit: BoxFit.cover),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(20)),
                            width: ScreenUtil().setWidth(2),
                            color: ThemeColors.colorF6F6F8,
                            height: ScreenUtil().setWidth(35),
                          ),
                          Expanded(
                              child: TextField(
                                  cursorColor: ThemeColors.homemainColor,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  autocorrect: true, //是否自动更正
                                  autofocus: true, //是否自动对焦
                                  obscureText: false, //是否是密码
                                  textAlign: TextAlign.left, //文本对齐方式
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(28),
                                      color: Colors.black), //输入文本的样式
                                  onSubmitted: (String result) {
                                    // widget.textFieldResults(result);
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      // 不是焦点的时候颜色
                                      borderSide: BorderSide(
                                          color: ThemeColors.colorF6F6F8),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      // 焦点集中的时候颜色
                                      borderSide: BorderSide(
                                          color: ThemeColors.colorF6F6F8),
                                    ),
                                    hintText: "请输入姓名",
                                    hintStyle: TextStyle(
                                      color: ThemeColors.titleColor,
                                      fontSize: ScreenUtil().setSp(28),
                                    ),
                                  )))
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setWidth(10)),
                      Row(
                        children: [
                          Image(
                              width: ScreenUtil().setWidth(45),
                              height: ScreenUtil().setWidth(45),
                              image: AssetImage(
                                Utils.getImgPath('card'),
                              ),
                              fit: BoxFit.cover),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(20)),
                            width: ScreenUtil().setWidth(2),
                            color: ThemeColors.colorF6F6F8,
                            height: ScreenUtil().setWidth(35),
                          ),
                          Expanded(
                              child: TextField(
                                  cursorColor: ThemeColors.homemainColor,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  autocorrect: true, //是否自动更正
                                  autofocus: true, //是否自动对焦
                                  obscureText: false, //是否是密码
                                  textAlign: TextAlign.left, //文本对齐方式
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(28),
                                      color: Colors.black), //输入文本的样式
                                  onSubmitted: (String result) {
                                    // widget.textFieldResults(result);
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      // 不是焦点的时候颜色
                                      borderSide: BorderSide(
                                          color: ThemeColors.colorF6F6F8),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      // 焦点集中的时候颜色
                                      borderSide: BorderSide(
                                          color: ThemeColors.colorF6F6F8),
                                    ),
                                    hintText: "请输入身份证号码",
                                    hintStyle: TextStyle(
                                      color: ThemeColors.titleColor,
                                      fontSize: ScreenUtil().setSp(28),
                                    ),
                                  )))
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setWidth(70)),
                      OnTopBotton(
                        callBack: () {},
                        widget: Container(
                          alignment: Alignment.center,
                         
                         
                          margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20),
                          ),
                          height: ScreenUtil().setWidth(88),
                          decoration: BoxDecoration(
                              color: ThemeColors.homemainColor,
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().setWidth(44))),
                          child: Text("确认提交",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(32),
                                color: ThemeColors.appliedColor, //35,17,0
                              )),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static modalButtomSheet({
    @required BuildContext context,
  }) async {
    showModalBottomSheet(
        context: context,
        // isScrollControlled: true,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text("设置"),
              onTap: () => Navigator.pop(context),
            ),
          );
        });
  }
}
