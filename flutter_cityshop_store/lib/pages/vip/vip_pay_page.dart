import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_cityshop_store/widget/onTop_botton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VipPayPages extends StatefulWidget {
  VipPayPages({Key key}) : super(key: key);

  @override
  _VipPayPagesState createState() => _VipPayPagesState();
}

class _VipPayPagesState extends State<VipPayPages> {
  //默认选择白银会员
  bool silver = true;

  String pay = '19.9';
  List dataSource = [
    {"title": "有效时间", "silver": "1个月", "gold": "3个月"},
    {"title": "黑名单检测", "silver": "¥29.9", "gold": "¥39.9"},
    {"title": "拒就赔抵用券", "silver": "¥20", "gold": "¥40"},
    {"title": "新口子提醒", "silver": "¥20", "gold": "¥40"},
    {"title": "会员专属产品", "silver": "¥39.9", "gold": "¥49.9"},
    {"title": "优惠券礼包", "silver": "¥39", "gold": "¥54"},
    {"title": "仅售", "silver": "¥19.9", "gold": "¥39.9"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0, // 隐藏阴影
            backgroundColor: ThemeColors.mainBgColor,
            title: Text(
              "超级VIP",
              style: TextStyle(
                  color: ThemeColors.titlesColor,
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenUtil().setSp(38)),
            ),
            centerTitle: true,
            leading: IconButton(
                icon:
                    Icon(Icons.arrow_back_ios, color: ThemeColors.titlesColor),
                onPressed: () {
                  Navigator.pop(context);
                })),
        body: Column(
          //228,117,34,1
          children: [
            _tagJoin(title: '选择VIP'),
            _choseVip(),
            _tagJoin(title: '请选择支付方式'),
            _alPay(),
            _alPayText(),
            _toPayVip()
          ],
        ));
  }

  Widget _alPayText() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(30),
              vertical: ScreenUtil().setWidth(20)),
          child: Text(
            "确认支付即代表您同意《会员服务协议》",
            style: TextStyle(
                color: ThemeColors.mainColor, fontSize: ScreenUtil().setSp(28)),
          ),
        )
      ],
    );
  }

  Widget _alPay() {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(30),
                vertical: ScreenUtil().setWidth(20)),
            width: ScreenUtil().setWidth(265),
            height: ScreenUtil().setWidth(110),
            decoration: BoxDecoration(
                border:
                    new Border.all(color: ThemeColors.mainColor, width: 0.8),
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                    width: ScreenUtil().setWidth(60),
                    height: ScreenUtil().setWidth(60),
                    image: AssetImage(
                      Utils.getImgPath("alipay"),
                    ),
                    fit: BoxFit.cover),
                Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                  child: Text(
                    "支付宝",
                    style: TextStyle(
                        color: ThemeColors.vipsubtitleColor,
                        fontSize: ScreenUtil().setSp(32)),
                  ),
                )
              ],
            ))
      ],
    );
  }

  Widget _choseVip() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(30),
          vertical: ScreenUtil().setWidth(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _tagVip(tagVip: 'silver', tag: '白银VIP', select: silver),
          _tagVip(tagVip: 'gold', tag: '黄金VIP', select: !silver)
        ],
      ),
    );
  }

  Widget _tagVip(
      {@required String tagVip, @required String tag, @required bool select}) {
    List<Widget> listWidget = dataSource.map((val) {
      return Container(
          margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(8)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              val["title"] ?? "",
              style: TextStyle(
                  color:
                      select ? ThemeColors.mainColor : ThemeColors.payTextColor,
                  fontSize: ScreenUtil().setSp(32)),
            ),
            Text(
              val[tagVip] ?? "",
              style: TextStyle(
                  //  decoration: TextDecoration.lineThrough,
                  color:
                      select ? ThemeColors.mainColor : ThemeColors.payTextColor,
                  fontSize: ScreenUtil().setSp(32)),
            )
          ]));
    }).toList();
    return InkWell(
      onTap: () {
        print("选择---");
        if (!select) {
          var payNum;
          print("选择---$tag-$select");
          if (tagVip  == "silver") {
              payNum = "19.9";
          } else {
             payNum = "39.9";
          }

         this.setState(() {
            silver = !silver;
            pay = payNum;
          });
        }
      },
      child: Container(
          width: ScreenUtil().setWidth(335),
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(15)),
          decoration: BoxDecoration(
              border: new Border.all(
                  color: select ? ThemeColors.mainColor : Colors.white,
                  width: 0.8),
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tag ?? "",
                style: TextStyle(
                    color: ThemeColors.vipsubtitleColor,
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtil().setSp(38)),
              ),
              Column(
                children: listWidget,
              )
            ],
          )),
    );
  }
  Widget _toPayVip() {
    return OnTopBotton(
      callBack: () {},
      widget: Container(
        margin: EdgeInsets.only(top: 30),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(680),
        height: ScreenUtil().setWidth(100),
        decoration: BoxDecoration(
            color: ThemeColors.mainColor,
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(50))),
        child: Text("确认支付$pay元",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(32),
              color: Colors.white,
            )),
      ),
    );
  }

  Widget _tagJoin({@required String title}) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(30),
          vertical: ScreenUtil().setWidth(30)),
      child: Row(
        children: [
          Container(
            width: ScreenUtil().setWidth(10),
            height: ScreenUtil().setWidth(40),
            color: ThemeColors.payColor,
          ),
          Container(
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
            child: Text(
              title ?? "",
              style: TextStyle(
                  color: ThemeColors.vipsubtitleColor,
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenUtil().setSp(32)),
            ),
          )
        ],
      ),
    );
  }
}