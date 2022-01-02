class AppConfig {
  String createTime;
  String updateTime;
  String createBy;
  String updateBy;
  int id;
  int isShow;
  String showArea;
  String showAreaName;

  AppConfig(
      {this.createTime,
      this.updateTime,
      this.createBy,
      this.updateBy,
      this.id,
      this.isShow,
      this.showArea,
      this.showAreaName});

  AppConfig.fromJson(Map<String, dynamic> json) {
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    createBy = json['createBy'];
    updateBy = json['updateBy'];
    id = json['id'];
    isShow = json['isShow'];
    showArea = json['showArea'];
    showAreaName = json['showAreaName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['createBy'] = this.createBy;
    data['updateBy'] = this.updateBy;
    data['id'] = this.id;
    data['isShow'] = this.isShow;
    data['showArea'] = this.showArea;
    data['showAreaName'] = this.showAreaName;
    return data;
  }
}
