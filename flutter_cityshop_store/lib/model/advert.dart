class Advert {
  int productId;
  String productName;
  String longContent;
  int loanUpper;
  int loanLower;
  int applyNum;
  String productUrl;
  String  bannerImgUrl;
  Null miScoreSwitch;
  Null miScore;
  Null miScoreNum;

  Advert(
      {this.productId,
      this.productName,
      this.longContent,
      this.loanUpper,
      this.loanLower,
      this.applyNum,
      this.productUrl,
      this.bannerImgUrl,
      this.miScoreSwitch,
      this.miScore,
      this.miScoreNum});

  Advert.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    longContent = json['longContent'];
    loanUpper = json['loanUpper'];
    loanLower = json['loanLower'];
    applyNum = json['applyNum'];
    productUrl = json['productUrl'];
    bannerImgUrl = json['bannerImgUrl'];
    miScoreSwitch = json['miScoreSwitch'];
    miScore = json['miScore'];
    miScoreNum = json['miScoreNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['longContent'] = this.longContent;
    data['loanUpper'] = this.loanUpper;
    data['loanLower'] = this.loanLower;
    data['applyNum'] = this.applyNum;
    data['productUrl'] = this.productUrl;
    data['bannerImgUrl'] = this.bannerImgUrl;
    data['miScoreSwitch'] = this.miScoreSwitch;
    data['miScore'] = this.miScore;
    data['miScoreNum'] = this.miScoreNum;
    return data;
  }
}