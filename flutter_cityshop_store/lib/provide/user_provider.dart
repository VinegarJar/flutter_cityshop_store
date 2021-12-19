import 'package:flutter/cupertino.dart';

import 'package:flutter_cityshop_store/model/userinfo.dart';

class UserProvider with ChangeNotifier {
  //用户信息
  UserInfo userInfo;

  //是否实名制realNameVerify,是否实名认证 0 否  1 是
  bool isReal = false;

  //是否vip,vipLevel, VIP等级 0 普通 1 vip用户
  bool isVIP = false;

  savaUserInfoCache(UserInfo user) {
    userInfo = user;

    if (userInfo.realNameVerify == 1) {
      isReal = true;
    }
    if (userInfo.vipLevel == 1) {
      isVIP = true;
    }
    notifyListeners();
  }

  cleanUserInfoCache(){
     userInfo = null;
     isReal = false;
     isVIP = false;
  }
   

}
