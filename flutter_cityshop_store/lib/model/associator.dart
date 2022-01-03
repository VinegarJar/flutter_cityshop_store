class Associator {
  int productId;
  int loanUpper;
  int loanLower;
  String loanPeriodUpper;
  String loanPeriodLower;
  String loanSpeed;
  Null applyCondition;
  String productDesc;
  String productName;
  String shortContent;
  String longContent;
  Null productPrice;
  Null productUrl;
  String applyNum;
  Null productShortUrl;
  int status;
  int createTime;
  Null updateTime;
  Null quickWeight;
  Null recommendWeight;
  Null listWeight;
  Null mustWeight;
  String rate;
  String productImgUrl;
  int miScoreSwitch;
  int miScore;
  int miScoreNum;
  Null business;

  Associator(
      {this.productId,
      this.loanUpper,
      this.loanLower,
      this.loanPeriodUpper,
      this.loanPeriodLower,
      this.loanSpeed,
      this.applyCondition,
      this.productDesc,
      this.productName,
      this.shortContent,
      this.longContent,
      this.productPrice,
      this.productUrl,
      this.applyNum,
      this.productShortUrl,
      this.status,
      this.createTime,
      this.updateTime,
      this.quickWeight,
      this.recommendWeight,
      this.listWeight,
      this.mustWeight,
      this.rate,
      this.productImgUrl,
      this.miScoreSwitch,
      this.miScore,
      this.miScoreNum,
      this.business});

  Associator.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    loanUpper = json['loanUpper'];
    loanLower = json['loanLower'];
    loanPeriodUpper = json['loanPeriodUpper'];
    loanPeriodLower = json['loanPeriodLower'];
    loanSpeed = json['loanSpeed'];
    applyCondition = json['applyCondition'];
    productDesc = json['productDesc'];
    productName = json['productName'];
    shortContent = json['shortContent'];
    longContent = json['longContent'];
    productPrice = json['productPrice'];
    productUrl = json['productUrl'];
    applyNum = json['applyNum'];
    productShortUrl = json['productShortUrl'];
    status = json['status'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    quickWeight = json['quickWeight'];
    recommendWeight = json['recommendWeight'];
    listWeight = json['listWeight'];
    mustWeight = json['mustWeight'];
    rate = json['rate'];
    productImgUrl = json['productImgUrl'];
    miScoreSwitch = json['miScoreSwitch'];
    miScore = json['miScore'];
    miScoreNum = json['miScoreNum'];
    business = json['business'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['loanUpper'] = this.loanUpper;
    data['loanLower'] = this.loanLower;
    data['loanPeriodUpper'] = this.loanPeriodUpper;
    data['loanPeriodLower'] = this.loanPeriodLower;
    data['loanSpeed'] = this.loanSpeed;
    data['applyCondition'] = this.applyCondition;
    data['productDesc'] = this.productDesc;
    data['productName'] = this.productName;
    data['shortContent'] = this.shortContent;
    data['longContent'] = this.longContent;
    data['productPrice'] = this.productPrice;
    data['productUrl'] = this.productUrl;
    data['applyNum'] = this.applyNum;
    data['productShortUrl'] = this.productShortUrl;
    data['status'] = this.status;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['quickWeight'] = this.quickWeight;
    data['recommendWeight'] = this.recommendWeight;
    data['listWeight'] = this.listWeight;
    data['mustWeight'] = this.mustWeight;
    data['rate'] = this.rate;
    data['productImgUrl'] = this.productImgUrl;
    data['miScoreSwitch'] = this.miScoreSwitch;
    data['miScore'] = this.miScore;
    data['miScoreNum'] = this.miScoreNum;
    data['business'] = this.business;
    return data;
  }
}
