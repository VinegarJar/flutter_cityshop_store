class UserInfo {
  int id;
  String phoneNum;
  Null uuid;
  String smsCode;
  int smsCodeTime;
  String nickName;
  Null wechatNum;
  Null qqNum;
  String idNum;
  Null phoneNumVerify;
  int realNameVerify;
  int realNameNeed;
  Null plaintPassword;
  String channelId;
  int channelVisitTime;
  Null appStoreUuid;
  Null appStoreVisitTime;
  Null iosVisited;
  Null iosVisiteTime;
  int androidVisited;
  Null androidVisiteTime;
  Null basicInfoVerify;
  Null yysVerify;
  Null taobaoVerify;
  Null chsiVerify;
  Null shebaoVerify;
  Null gjjVerify;
  Null bankVerify;
  Null videoVerify;
  Null identityVerify;
  Null debitVerify;
  Null creditVerify;
  Null payedMoneyForCredit;
  int userType;
  int userAppType;
  Null lastLoginDeviceManufacturer;
  Null loginDeviceManufacturer;
  Null phoneAddresses;
  Null phoneCtype;
  Null phoneOperators;
  Null productUuid;
  Null loanAmount;
  int coin;
  Null creditScore;
  Null cash;
  String miId;
  int miScore;
  String appVersion;
  String url;
  int status;
  int preSwitch;
  int vipLevel;
  String validDate;

  UserInfo(
      {this.id,
      this.phoneNum,
      this.uuid,
      this.smsCode,
      this.smsCodeTime,
      this.nickName,
      this.wechatNum,
      this.qqNum,
      this.idNum,
      this.phoneNumVerify,
      this.realNameVerify,
      this.realNameNeed,
      this.plaintPassword,
      this.channelId,
      this.channelVisitTime,
      this.appStoreUuid,
      this.appStoreVisitTime,
      this.iosVisited,
      this.iosVisiteTime,
      this.androidVisited,
      this.androidVisiteTime,
      this.basicInfoVerify,
      this.yysVerify,
      this.taobaoVerify,
      this.chsiVerify,
      this.shebaoVerify,
      this.gjjVerify,
      this.bankVerify,
      this.videoVerify,
      this.identityVerify,
      this.debitVerify,
      this.creditVerify,
      this.payedMoneyForCredit,
      this.userType,
      this.userAppType,
      this.lastLoginDeviceManufacturer,
      this.loginDeviceManufacturer,
      this.phoneAddresses,
      this.phoneCtype,
      this.phoneOperators,
      this.productUuid,
      this.loanAmount,
      this.coin,
      this.creditScore,
      this.cash,
      this.miId,
      this.miScore,
      this.appVersion,
      this.url,
      this.status,
      this.preSwitch,
      this.vipLevel,
      this.validDate});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNum = json['phoneNum'];
    uuid = json['uuid'];
    smsCode = json['smsCode'];
    smsCodeTime = json['smsCodeTime'];
    nickName = json['nickName'];
    wechatNum = json['wechatNum'];
    qqNum = json['qqNum'];
    idNum = json['idNum'];
    phoneNumVerify = json['phoneNumVerify'];
    realNameVerify = json['realNameVerify'];
    realNameNeed = json['realNameNeed'];
    plaintPassword = json['plaintPassword'];
    channelId = json['channelId'];
    channelVisitTime = json['channelVisitTime'];
    appStoreUuid = json['appStoreUuid'];
    appStoreVisitTime = json['appStoreVisitTime'];
    iosVisited = json['iosVisited'];
    iosVisiteTime = json['iosVisiteTime'];
    androidVisited = json['androidVisited'];
    androidVisiteTime = json['androidVisiteTime'];
    basicInfoVerify = json['basicInfoVerify'];
    yysVerify = json['yysVerify'];
    taobaoVerify = json['taobaoVerify'];
    chsiVerify = json['chsiVerify'];
    shebaoVerify = json['shebaoVerify'];
    gjjVerify = json['gjjVerify'];
    bankVerify = json['bankVerify'];
    videoVerify = json['videoVerify'];
    identityVerify = json['identityVerify'];
    debitVerify = json['debitVerify'];
    creditVerify = json['creditVerify'];
    payedMoneyForCredit = json['payedMoneyForCredit'];
    userType = json['userType'];
    userAppType = json['userAppType'];
    lastLoginDeviceManufacturer = json['lastLoginDeviceManufacturer'];
    loginDeviceManufacturer = json['loginDeviceManufacturer'];
    phoneAddresses = json['phoneAddresses'];
    phoneCtype = json['phoneCtype'];
    phoneOperators = json['phoneOperators'];
    productUuid = json['productUuid'];
    loanAmount = json['loanAmount'];
    coin = json['coin'];
    creditScore = json['creditScore'];
    cash = json['cash'];
    miId = json['miId'];
    miScore = json['miScore'];
    appVersion = json['appVersion'];
    url = json['url'];
    status = json['status'];
    preSwitch = json['preSwitch'];
    vipLevel = json['vipLevel'];
    validDate = json['validDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phoneNum'] = this.phoneNum;
    data['uuid'] = this.uuid;
    data['smsCode'] = this.smsCode;
    data['smsCodeTime'] = this.smsCodeTime;
    data['nickName'] = this.nickName;
    data['wechatNum'] = this.wechatNum;
    data['qqNum'] = this.qqNum;
    data['idNum'] = this.idNum;
    data['phoneNumVerify'] = this.phoneNumVerify;
    data['realNameVerify'] = this.realNameVerify;
    data['realNameNeed'] = this.realNameNeed;
    data['plaintPassword'] = this.plaintPassword;
    data['channelId'] = this.channelId;
    data['channelVisitTime'] = this.channelVisitTime;
    data['appStoreUuid'] = this.appStoreUuid;
    data['appStoreVisitTime'] = this.appStoreVisitTime;
    data['iosVisited'] = this.iosVisited;
    data['iosVisiteTime'] = this.iosVisiteTime;
    data['androidVisited'] = this.androidVisited;
    data['androidVisiteTime'] = this.androidVisiteTime;
    data['basicInfoVerify'] = this.basicInfoVerify;
    data['yysVerify'] = this.yysVerify;
    data['taobaoVerify'] = this.taobaoVerify;
    data['chsiVerify'] = this.chsiVerify;
    data['shebaoVerify'] = this.shebaoVerify;
    data['gjjVerify'] = this.gjjVerify;
    data['bankVerify'] = this.bankVerify;
    data['videoVerify'] = this.videoVerify;
    data['identityVerify'] = this.identityVerify;
    data['debitVerify'] = this.debitVerify;
    data['creditVerify'] = this.creditVerify;
    data['payedMoneyForCredit'] = this.payedMoneyForCredit;
    data['userType'] = this.userType;
    data['userAppType'] = this.userAppType;
    data['lastLoginDeviceManufacturer'] = this.lastLoginDeviceManufacturer;
    data['loginDeviceManufacturer'] = this.loginDeviceManufacturer;
    data['phoneAddresses'] = this.phoneAddresses;
    data['phoneCtype'] = this.phoneCtype;
    data['phoneOperators'] = this.phoneOperators;
    data['productUuid'] = this.productUuid;
    data['loanAmount'] = this.loanAmount;
    data['coin'] = this.coin;
    data['creditScore'] = this.creditScore;
    data['cash'] = this.cash;
    data['miId'] = this.miId;
    data['miScore'] = this.miScore;
    data['appVersion'] = this.appVersion;
    data['url'] = this.url;
    data['status'] = this.status;
    data['preSwitch'] = this.preSwitch;
    data['vipLevel'] = this.vipLevel;
    data['validDate'] = this.validDate;
    return data;
  }
}
