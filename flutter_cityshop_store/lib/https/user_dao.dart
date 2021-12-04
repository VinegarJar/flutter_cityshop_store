import 'dart:convert';

import 'package:flutter_cityshop_store/common/config/config.dart';
import 'package:flutter_cityshop_store/common/local/local_storage.dart';
import 'package:flutter_cityshop_store/https/dao_result.dart';
import 'package:flutter_cityshop_store/model/userinfo.dart';

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
}
