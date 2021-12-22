import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';
import 'package:flutter_cityshop_store/common/event/http_error_event.dart';
import 'package:flutter_cityshop_store/common/local/local_storage.dart';
import 'package:flutter_cityshop_store/https/dao_result.dart';
import 'package:flutter_cityshop_store/https/httpRequest_method.dart';
import 'package:flutter_cityshop_store/model/userinfo.dart';
import 'package:flutter_cityshop_store/provide/user_provider.dart';
import 'package:flutter_cityshop_store/router/navigator_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class UserDao {
  ///初始化用户信息
  static initUserInfo() async {
    var token = await LocalStorage.get(Config.TOKEN_KEY);
    var res = await getUserInfoLocal();
    return new DataResult(res.data, (res.result && (token != null)));
  }

  ///获取本地登录用户信息
  static getUserInfoLocal() async {
    var userText = await LocalStorage.get(Config.USER_INFO);
    if (userText != null) {
      var userMap = json.decode(userText);
      UserInfo user = UserInfo.fromJson(userMap);
      return new DataResult(user, true);
    } else {
      return new DataResult(null, false);
    }
  }

  ///上传实名制用户信息
  static usercheck(params, context) async {
    await EasyLoading.show(
      status: '',
      maskType: EasyLoadingMaskType.black,
    );
    //上传实名制接口请求,更新用户信息
    var res = await HttpRequestMethod.instance
        .requestWithMetod(Config.userRealCheck, params);

    var data = res.data ?? {};

    print("上传实名制接口请求---->>>>>$data");

    if (data["code"] == 200) {
      updateUserInfo(context);
    } else {
      eventBus.fire(new HttpErrorEvent(99, data["msg"] ?? "认证失败!"));
    }
  }

  static updateUserInfo(context) async {
    var _phoneNum = await LocalStorage.get(Config.TOKEN_KEY);
    var params = {"phoneNum": _phoneNum};
    var res = await HttpRequestMethod.instance
        .requestWithMetod(Config.userInfo, params);
    UserInfo user = UserInfo.fromJson(res.data);
    print(
        "updateUserInfo---->>>>>${user.nickName}-realName-${user.realNameVerify}vipLevel-${user.vipLevel}");
    Provider.of<UserProvider>(context, listen: false).savaUserInfoCache(user);
    LocalStorage.save(Config.USER_INFO, json.encode(user.toJson()));
    Navigator.of(context).pop();
    EasyLoading.dismiss();
  }

  static jumpWebView(BuildContext context, var productId) async {
    var params = {"productId": productId};
    var res = await HttpRequestMethod.instance
        .requestWithMetod(Config.productUr, params);
    print("跳转产品地址----${res.data}");
    var result = res.data["result"] ?? "";
    NavigatorUtils.goProductWebView(
      context,
      result,
      "产品详情",
    );
     
    //  analysisHandle(productId);
  }

 static analysisHandle(var productId) async {
    var _phoneNum = await LocalStorage.get(Config.TOKEN_KEY);
    var params = {
      "phoneNum": _phoneNum,
      "event": "APP_PPV",
      "extraParam1":productId,//产品id
      "extraParam2":"首页推荐" 
    };

    var res = await HttpRequestMethod.instance
        .requestWithMetod(Config.addEventUrl, params);

      print("埋点上传----${res.data}");
  }



}
