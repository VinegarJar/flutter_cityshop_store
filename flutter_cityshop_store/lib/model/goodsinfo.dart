
class GoodsInfoModel {
  List<GoodsList> goodsList;

  int totalSize;
  List recommend;
  List mobile;
  List promotion;

  GoodsInfoModel({this.goodsList,
             this.totalSize,
             this.recommend,
             this.mobile,
             this.promotion});

  GoodsInfoModel.fromJson(Map<String, dynamic> json) {
    
    if (json['goods_list'] != null) {
      goodsList = new List<GoodsList>();
      json['goods_list'].forEach((v) {
        goodsList.add(new GoodsList.fromJson(v));
      });
    }
    totalSize = json['total_size'];
    recommend = json['home_recommend_subjects'];
    mobile = json['mobile_app_groups'];
    promotion = json['promotion_slip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.goodsList != null) {
      data['goods_list'] = this.goodsList.map((v) => v.toJson()).toList();
    }
    data['total_size'] = this.totalSize;
    return data;
  }
}

class GoodsList {
  int goodsId;
  String goodsName;
  String shortName;
  String imageUrl;
  String thumbUrl;
  String hdThumbUrl;
  int isApp;
  int eventType;
  Map group;
  int cnt;
  int marketPrice;
  int normalPrice;
  String country;
  String allowedRegion;
  int regionLimit;
  Map pRec;
  int isAssist;
  int assistCount;
  String salesTip;
  String linkUrl;
  String hdUrl;
  Map nearGroup;
  int count;

  GoodsList(
      {this.count,
      this.goodsId,
      this.goodsName,
      this.shortName,
      this.imageUrl,
      this.thumbUrl,
      this.hdThumbUrl,
      this.isApp,
      this.eventType,
      this.group,
      this.cnt,
      this.marketPrice,
      this.normalPrice,
      this.country,
      this.allowedRegion,
      this.regionLimit,
      this.pRec,
      this.isAssist,
      this.assistCount,
      this.salesTip,
      this.linkUrl,
      this.hdUrl,
      this.nearGroup});

  GoodsList.fromJson(Map<String, dynamic> json) {
    count =json['count'] != null ? json['count'] : 0;
    goodsId = json['goods_id'];
    goodsName = json['goods_name'];
    shortName = json['short_name'];
    imageUrl = json['image_url'];
    thumbUrl = json['thumb_url'];
    hdThumbUrl = json['hd_thumb_url'];
    isApp = json['is_app'];
    eventType = json['event_type'];
    group = json['group'] != null ? json['group'] : null;
    cnt = json['cnt'];
    marketPrice = json['market_price'];
    normalPrice = json['normal_price'];
    country = json['country'];
    allowedRegion = json['allowed_region'];
    regionLimit = json['region_limit'];
    pRec = json['p_rec'] != null ? json['p_rec'] : null;
    isAssist = json['is_assist'];
    assistCount = json['assist_count'];
    salesTip = json['sales_tip'];
    linkUrl = json['link_url'];
    hdUrl = json['hd_url'];
    nearGroup = json['near_group'] != null ? json['near_group'] : null;
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['goods_id'] = this.goodsId;
    data['goods_name'] = this.goodsName;
    data['short_name'] = this.shortName;
    data['image_url'] = this.imageUrl;
    data['thumb_url'] = this.thumbUrl;
    data['hd_thumb_url'] = this.hdThumbUrl;
    data['is_app'] = this.isApp;
    data['event_type'] = this.eventType;
    if (this.group != null) {
      data['group'] = this.group;
    }
    data['cnt'] = this.cnt;
    data['market_price'] = this.marketPrice;
    data['normal_price'] = this.normalPrice;
    data['country'] = this.country;
    data['allowed_region'] = this.allowedRegion;
    data['region_limit'] = this.regionLimit;
    if (this.pRec != null) {
      data['p_rec'] = this.pRec;
    }
    data['is_assist'] = this.isAssist;
    data['assist_count'] = this.assistCount;
    data['sales_tip'] = this.salesTip;
    data['link_url'] = this.linkUrl;
    data['hd_url'] = this.hdUrl;
    if (this.nearGroup != null) {
      data['near_group'] = this.nearGroup;
    }
    return data;
  }

}


