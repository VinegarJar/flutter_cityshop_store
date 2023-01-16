import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';
import 'package:flutter_cityshop_store/https/httpRequest_method.dart';
import 'package:flutter_cityshop_store/model/associator.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_cityshop_store/widget/associator_item.dart';
import 'package:flutter_cityshop_store/widget/placeitem.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VipAssociator extends StatefulWidget {
  VipAssociator({Key key}) : super(key: key);

  @override
  _VipAssociatorState createState() => _VipAssociatorState();
}

class _VipAssociatorState extends State<VipAssociator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.mainBgColor,
      appBar: AppBar(
          elevation: 0, // 隐藏阴影
          backgroundColor: ThemeColors.mainBgColor,
          title: Text(
            "会员独享专区",
            style: TextStyle(
                color: ThemeColors.titlesColor,
                fontWeight: FontWeight.w500,
                fontSize: ScreenUtil().setSp(38)),
          ),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: ThemeColors.titlesColor),
              onPressed: () {
                 Navigator.pop(context);
              })),
      body: FutureBuilder(
        future: HttpRequestMethod.instance.requestWithMetod(
            Config.getVipProductList, {"pageNum": 1, "pageSize": 10}),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            var res = snapshot.data;
            List<Map> list = [];
            if ((res.data["list"] is List)) {
              list = (res.data["list"] as List).cast<Map>();
            }
            final List dataSource =
                list.map((data) => Associator.fromJson(data)).toList();

            print('获取CaterGoryPages信息----res----$dataSource');

            return ListView(
              children: [
                banner(),
                ListView.builder(
                  shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
                  physics: NeverScrollableScrollPhysics(), //禁用滑动事件
                  itemCount: dataSource.length,
                  itemBuilder: (BuildContext context, int index) {
                    Associator model = dataSource[index];
                    return AssociatorItem(model: model);
                  },
                )
              ],
            );
          } else {
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return PlaceItem();
              },
            );
          }
        },
      ),
    );
  }

  Widget banner() {
    return (Container(
        width: ScreenUtil().setWidth(750),
        height: ScreenUtil().setWidth(245),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Utils.getImgPath('associators'),
            ),
            fit: BoxFit.cover,
          ),
        )));
  }
}
