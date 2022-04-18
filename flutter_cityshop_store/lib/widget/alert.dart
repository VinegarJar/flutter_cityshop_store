import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cityshop_store/common/event/http_error_event.dart';
import 'package:flutter_cityshop_store/common/local/local_storage.dart';
import 'package:flutter_cityshop_store/https/user_dao.dart';
import 'package:flutter_cityshop_store/router/navigator_utils.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_cityshop_store/widget/onTop_botton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

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

  static showPolicySheet({
    @required String url,
    @required BuildContext context,
    @required Function() onPressed,
  }) async {
    await showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(ScreenUtil().setWidth(20)))),
          content: Container(
              width: ScreenUtil().setWidth(600),
              height: ScreenUtil().setWidth(860),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setWidth(20),
                        bottom: ScreenUtil().setWidth(10)),
                    child: Text(
                      "用呗隐私政策协议",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(34),
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    height: ScreenUtil().setWidth(450),
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(30)),
                    child: WebviewScaffold(
                      mediaPlaybackRequiresUserGesture: false,
                      url: Uri.dataFromString(url,
                              mimeType: 'text/html',
                              encoding: Encoding.getByName('utf-8'))
                          .toString(),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setWidth(20)),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(40)),
                    child: Text.rich(TextSpan(children: [
                      TextSpan(
                        text: "点击同意授权并继续视为您已阅读并同意",
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(32),
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "《用呗用户注册协议》",
                        style: TextStyle(
                          color: ThemeColors.colorRed,
                          fontSize: ScreenUtil().setSp(32),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            String fileUrl = await rootBundle
                                .loadString(Utils.getHtmlPath('agreement'));
                            NavigatorUtils.goToHtmlWebView(
                                context, fileUrl, "用呗用户注册协议");
                          },
                      ),
                      TextSpan(
                        text: "《用呗隐私政策》",
                        style: TextStyle(
                          color: ThemeColors.colorRed,
                          fontSize: ScreenUtil().setSp(32),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            String fileUrl = await rootBundle
                                .loadString(Utils.getHtmlPath('privacy'));
                            NavigatorUtils.goToHtmlWebView(
                                context, fileUrl, "用呗隐私政策");
                          },
                      ),
                    ])),
                  ),
                  SizedBox(height: ScreenUtil().setWidth(20)),
                  OnTopBotton(
                    callBack: () async {
                      LocalStorage.save("policy", "1");
                      Navigator.of(context).pop();
                      onPressed();
                    },
                    widget: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20)),
                      height: ScreenUtil().setWidth(66),
                      decoration: BoxDecoration(
                          color: ThemeColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setWidth(33))),
                      child: Text("同意授权并继续",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(32),
                            color: ThemeColors.mainBgColor, //35,17,0
                          )),
                    ),
                  ),
                  OnTopBotton(
                    callBack: () async {
                      SystemNavigator.pop();
                    },
                    widget: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20)),
                      height: ScreenUtil().setWidth(66),
                      child: Text("不同意,退出App",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(32),
                            color: ThemeColors.mainColor, //35,17,0
                          )),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }

  static showDialogSheet({
    @required BuildContext context,
    Function(Map<String, dynamic> result) onPressed,
  }) async {
    String _names = "";
    String _idNum = "";
    await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(ScreenUtil().setWidth(20)))),
          content: Container(
            width: ScreenUtil().setWidth(600),
            height: ScreenUtil().setWidth(580),
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
                                  inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(11),
                              ],
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
                                  onChanged: (result) {
                                    _names = result;
                                  },
                                  onSubmitted: (String result) {
                                    _names = result;
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
                                  inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(30),
                              ],
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
                                  onChanged: (result) {
                                    _idNum = result;
                                  },
                                  onSubmitted: (String result) {
                                    _idNum = result;
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
                        callBack: () async {
                          if (_names.isEmpty) {
                            return eventBus
                                .fire(new HttpErrorEvent(99, "请输入姓名"));
                          }
                          if (_idNum.isEmpty) {
                            return eventBus
                                .fire(new HttpErrorEvent(99, "请输身份证号码"));
                          }
                          var params = {
                            "names": _names,
                            "idNum": _idNum, //身份证号码
                          };
                          UserDao.usercheck(params, context);
                          // bool checkCard = CheckOutils.checkCard(_idNum);
                          // if (checkCard) {

                          //    UserDao.usercheck(params, context);
                          // } else {
                          //   eventBus.fire(
                          //       new HttpErrorEvent(99, "输入身份证号码有误,请重新输入!"));
                          // }
                        },
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

  static showAssociatorSheet({
    @required BuildContext context,
    @required Function() gotoVipPressed,
    bool cancel = false,
    Function() onPressed,
  }) async {
    await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: ScreenUtil().setWidth(600),
                height: ScreenUtil().setWidth(580),
                decoration: BoxDecoration(
                    color: cancel ? Colors.white : ThemeColors.associatorColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: [
                    cancel
                        ? Container()
                        : Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(25),
                                vertical: ScreenUtil().setWidth(5)),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(34, 31, 27, 0.8),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(
                                      ScreenUtil().setWidth(20)),
                                  bottomRight: Radius.circular(
                                      ScreenUtil().setWidth(20)),
                                )),
                            child: Text("会员专享产品",
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(38),
                                  color: ThemeColors.associatorColor,
                                  fontWeight: FontWeight.w600,
                                ))),
                    cancel
                        ? Container(
                            margin:
                                EdgeInsets.only(top: ScreenUtil().setWidth(30)),
                            child: Text("真的要放弃吗?",
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(40),
                                  color: ThemeColors.appliedColor,
                                  fontWeight: FontWeight.w600,
                                )))
                        : Container(
                            margin: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setWidth(20)),
                            child: Text("开通会员即可解锁",
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(36),
                                  color: cancel
                                      ? ThemeColors.appliedColor
                                      : ThemeColors.titlesColor,
                                  fontWeight: FontWeight.w600,
                                ))),
                    cancel
                        ? Container(
                            margin:
                                EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                            child: Text("98%的用户开通会员后下款成功",
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(28),
                                  color: Color.fromRGBO(195, 121, 81, 1),
                                  fontWeight: FontWeight.w500,
                                )))
                        : Container(
                            child: Text("高通过率产品",
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(40),
                                  color: Color.fromRGBO(195, 121, 81, 1),
                                  fontWeight: FontWeight.w500,
                                ))),
                    cancel
                        ? Container(
                            margin:
                                EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                            child: Text("开通会员即可享受以下权益",
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(28),
                                  color: Color.fromRGBO(202, 200, 200, 1),
                                  fontWeight: FontWeight.w500,
                                )))
                        : Container(),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setWidth(20)),
                      width: ScreenUtil().setWidth(500),
                      height: ScreenUtil().setWidth(200),
                      decoration: BoxDecoration(
                          color: ThemeColors.whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ItemImage(url: 'privilege_verify', title: '优先审核'),
                          ItemImage(url: 'privilege_money', title: '拒就赔保障'),
                          ItemImage(url: 'privilege_pass', title: '高通过率')
                        ],
                      ),
                    ),
                    OnTopBotton(
                      callBack: () async {
                        Navigator.of(context).pop();
                        gotoVipPressed();
                      },
                      widget: Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        width: ScreenUtil().setWidth(320),
                        height: ScreenUtil().setWidth(80),
                        decoration: BoxDecoration(
                            color: ThemeColors.toastColor,
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(40))),
                        child: Text("立即开通",
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(30),
                              color: ThemeColors.whiteColor, //35,17,0
                            )),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  onPressed();
                },
                child: Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setWidth(50)),
                  padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                  child: Icon(CupertinoIcons.xmark_circle,
                      size: ScreenUtil().setSp(80),
                      color: ThemeColors.whiteColor),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class ItemImage extends StatelessWidget {
  final String url;
  final String title;
  const ItemImage({Key key, @required this.url, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
              width: ScreenUtil().setWidth(80),
              height: ScreenUtil().setWidth(80),
              image: AssetImage(
                Utils.getImgPath(url ?? ""),
              ),
              fit: BoxFit.cover),
          SizedBox(width: ScreenUtil().setWidth(20)),
          Text(
            title ?? "",
            style: TextStyle(fontSize: ScreenUtil().setSp(28)),
          )
        ],
      ),
    );
  }
}
