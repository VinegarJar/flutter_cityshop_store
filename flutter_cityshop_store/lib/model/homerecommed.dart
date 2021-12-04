class HomeRecommed {
  int createTime;
  Null updateTime;
  Null createBy;
  Null updateBy;
  Null id;
  int productId;
  String productName;
  String productDesc;
  String shortContent;
  String longContent;
  Null applyCondition;
  Null checkData;
  int loanUpper;
  int loanLower;
  String loanPeriodUpper;
  String loanPeriodLower;
  String loanSpeed;
  String rate;
  int applyNum;
  Null productUrl;
  Null productShortUrl;
  Null settlementType;
  Null settlementPrice;
  Null productAdminUrl;
  Null productAccount;
  Null productPassword;
  String productImgUrl;
  int miScoreSwitch;
  int miScore;
  int miScoreNum;
  Null business;

  HomeRecommed(
      {this.createTime,
      this.updateTime,
      this.createBy,
      this.updateBy,
      this.id,
      this.productId,
      this.productName,
      this.productDesc,
      this.shortContent,
      this.longContent,
      this.applyCondition,
      this.checkData,
      this.loanUpper,
      this.loanLower,
      this.loanPeriodUpper,
      this.loanPeriodLower,
      this.loanSpeed,
      this.rate,
      this.applyNum,
      this.productUrl,
      this.productShortUrl,
      this.settlementType,
      this.settlementPrice,
      this.productAdminUrl,
      this.productAccount,
      this.productPassword,
      this.productImgUrl,
      this.miScoreSwitch,
      this.miScore,
      this.miScoreNum,
      this.business});

  HomeRecommed.fromJson(Map<String, dynamic> json) {
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    createBy = json['createBy'];
    updateBy = json['updateBy'];
    id = json['id'];
    productId = json['productId'];
    productName = json['productName'];
    productDesc = json['productDesc'];
    shortContent = json['shortContent'];
    longContent = json['longContent'];
    applyCondition = json['applyCondition'];
    checkData = json['checkData'];
    loanUpper = json['loanUpper'];
    loanLower = json['loanLower'];
    loanPeriodUpper = json['loanPeriodUpper'];
    loanPeriodLower = json['loanPeriodLower'];
    loanSpeed = json['loanSpeed'];
    rate = json['rate'];
    applyNum = json['applyNum'];
    productUrl = json['productUrl'];
    productShortUrl = json['productShortUrl'];
    settlementType = json['settlementType'];
    settlementPrice = json['settlementPrice'];
    productAdminUrl = json['productAdminUrl'];
    productAccount = json['productAccount'];
    productPassword = json['productPassword'];
    productImgUrl = json['productImgUrl'];
    miScoreSwitch = json['miScoreSwitch'];
    miScore = json['miScore'];
    miScoreNum = json['miScoreNum'];
    business = json['business'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['createBy'] = this.createBy;
    data['updateBy'] = this.updateBy;
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['productDesc'] = this.productDesc;
    data['shortContent'] = this.shortContent;
    data['longContent'] = this.longContent;
    data['applyCondition'] = this.applyCondition;
    data['checkData'] = this.checkData;
    data['loanUpper'] = this.loanUpper;
    data['loanLower'] = this.loanLower;
    data['loanPeriodUpper'] = this.loanPeriodUpper;
    data['loanPeriodLower'] = this.loanPeriodLower;
    data['loanSpeed'] = this.loanSpeed;
    data['rate'] = this.rate;
    data['applyNum'] = this.applyNum;
    data['productUrl'] = this.productUrl;
    data['productShortUrl'] = this.productShortUrl;
    data['settlementType'] = this.settlementType;
    data['settlementPrice'] = this.settlementPrice;
    data['productAdminUrl'] = this.productAdminUrl;
    data['productAccount'] = this.productAccount;
    data['productPassword'] = this.productPassword;
    data['productImgUrl'] = this.productImgUrl;
    data['miScoreSwitch'] = this.miScoreSwitch;
    data['miScore'] = this.miScore;
    data['miScoreNum'] = this.miScoreNum;
    data['business'] = this.business;
    return data;
  }
}