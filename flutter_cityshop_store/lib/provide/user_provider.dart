import 'package:flutter/cupertino.dart';

import 'package:flutter_cityshop_store/model/userinfo.dart';

class UserProvider with ChangeNotifier {

  //用户信息
  UserInfo userInfo;

  savaUserInfoCache(UserInfo user) {
    print("获取用户信息---->>>>${user.phoneNum}");
    userInfo = user;
    notifyListeners();
  }

  

}
