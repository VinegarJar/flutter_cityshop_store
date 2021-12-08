import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_cityshop_store/widget/tag.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MineServe extends StatefulWidget {
  MineServe({Key key}) : super(key: key);

  @override
  _MineServeState createState() => _MineServeState();
}

class _MineServeState extends State<MineServe> {
  final dataSource = [
    {"title": "查询逾期记录", "url": Utils.getImgPath('check'), "index": 1},
    {"title": "在线客服", "url": Utils.getImgPath('new'), "index": 2},
    {"title": "意见反馈", "url": Utils.getImgPath('feedback'), "index": 3},
    {"title": "设置", "url": Utils.getImgPath('set'), "index": 4}
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                vertical: ScreenUtil().setWidth(40),
                horizontal: ScreenUtil().setWidth(30)),
            child: Tage(titel: "专属服务"),
          ),
          _wrapList(dataSource, context),
          SizedBox(height: ScreenUtil().setWidth(15)),
        ],
      ),
    );
  }

  Widget _wrapList(List dataSource, BuildContext context) {
    if (dataSource.length != 0) {
      List<Widget> listWidget = dataSource.map((val) {
        return InkWell(
            onTap: () {
              print("火爆专区---$val---");
            },
            child: Container(
                width: MediaQuery.of(context).size.width / 4,
                margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(40)),
                child: Column(children: [
                  Image(
                      width: ScreenUtil().setWidth(50),
                      height: ScreenUtil().setWidth(50),
                      image: AssetImage(
                        val["url"],
                      ),
                      fit: BoxFit.contain),
                  SizedBox(
                    height: ScreenUtil().setWidth(20),
                  ),
                  Text(
                    val["title"],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: ThemeColors.titleColor,
                        fontSize: ScreenUtil().setSp(30)),
                  ),
                ])));
      }).toList();

      return Wrap(
        // spacing: 7.5, //左右
        runSpacing: ScreenUtil().setWidth(10), //上下
        children: listWidget, //加载子组件
      );
    } else {
      return Text('加载错误!');
    }
  }
}
