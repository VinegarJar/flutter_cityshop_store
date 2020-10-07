class CategoryModel {
  int status;
  String message;
  String code;

  //右侧分类标签数据
  List<Category> category;
  //左侧标签数据
  List<Results> results ;

  CategoryModel({
    this.status, 
    this.message, 
    this.code, 
    this.category, 
    this.results});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    if (json['category'] != null) {
      category = new List<Category>();
      json['category'].forEach((v) {
        category.add(new Category.fromJson(v));
      });
    }
    if (json['items'] != null) {
      results = new List<Results>();
      json['items'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Results {
  String categoryName;
  String type;
  String createdAt;
  String updatedAt;
  String objectId;
  int   isIndex;

  Results({
    this.categoryName,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.objectId,
    this.isIndex,
  });

  Results.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    objectId = json['objectId'];
    isIndex = json['isIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryName'] = this.categoryName;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['objectId'] = this.objectId;
    data['isIndex'] = this.isIndex;
    return data;
  }
}

class Category {
  List<String> pic;
  List<ListItem> list;

  Category({this.pic, this.list});

  Category.fromJson(Map<String, dynamic> json) {
    pic = json['pic'].cast<String>();
    if (json['list'] != null) {
      list = new List<ListItem>();
      json['list'].forEach((v) {
        list.add(new ListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pic'] = this.pic;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListItem {
  String title;
  List goods;

  ListItem({this.title, this.goods});

  ListItem.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    goods = json['goods'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.goods != null) {
      data['goods'] = this.goods.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
