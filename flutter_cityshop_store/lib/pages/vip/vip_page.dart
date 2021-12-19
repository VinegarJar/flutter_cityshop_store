import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/router/navigator_utils.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VipPages extends StatefulWidget {
  VipPages({Key key}) : super(key: key);

  @override
  _VipPagesState createState() => _VipPagesState();
}

class _VipPagesState extends State<VipPages> {
  



  List dataSource = [
    {"name": "privilege_check", "title": "黑名单检测", "text": "会员免费 原价39.9元"},
    {"name": "privilege_risk", "title": "网袋风险检测", "text": "会员免费 原价59.9元"},
    {"name": "privilege_verify", "title": "优先审核", "text": "独享优先审核 最高提速50%"},
    {"name": "privilege_pass", "title": "高通过率", "text": "优质名额 最高提速50%通过率"}
  ];

  @override
  void initState() {
    super.initState();
    Fluttertoast.showToast(
      msg: "该产品为会员专属产品,开通后即可解锁",
      fontSize: ScreenUtil().setSp(32),
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
    );
  }

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
          children: [
            Expanded(
                child: ListView(
              children: [
                Image(
                    width: ScreenUtil().setWidth(750),
                    image: AssetImage(
                      Utils.getImgPath('vip'),
                    ),
                    fit: BoxFit.cover),
                _privilege(name: 'privilege_1', titel: '借款特权'),
                _vipOnly(
                  context,
                  name: 'privilege_money',
                  titel: '拒就赔',
                  text: '最高可领100元(限指定产品)',
                  subtitel: '去使用',
                ),
                _privilege(name: 'privilege_2', titel: '会员专属产品'),
                _vipOnlyPrivilege(),
                _privilege(name: 'privilege_3', titel: '下载工具'),
                _toolList(context),
              ],
            )),
            _vipJoin(context)
          ],
        ));
  }

  Widget _toolList(BuildContext context) {
    List<Widget> listWidget = dataSource.map((val) {
      return _vipOnly(
        context,
        name: val["name"],
        titel: val["title"],
        text: val["text"],
        subtitel: '去检测',
      );
    }).toList();
    return Column(
      children: listWidget,
    );
  }

  Widget _vipJoin(BuildContext context) {
    return InkWell(
        onTap: () {
          print("即刻加入");
            NavigatorUtils.gotoPayVip(context);
        },
        child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20),
                vertical: ScreenUtil().setWidth(20)),
            height: ScreenUtil().setWidth(90),
            decoration: BoxDecoration(
                color: ThemeColors.jionColor,
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(20))),
            child: Text(
              "即刻加入",
              style: TextStyle(
                  color: ThemeColors.jionTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenUtil().setSp(36)),
            )));
  }

  Widget _vipOnly(
      BuildContext context,
      {@required String name,
      @required String titel,
      @required String text,
      String subtitel}) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(35),
          vertical: ScreenUtil().setWidth(10)),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
      height: ScreenUtil().setWidth(90),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image(
                  width: ScreenUtil().setWidth(88),
                  height: ScreenUtil().setWidth(88),
                  image: AssetImage(
                    Utils.getImgPath(name),
                  ),
                  fit: BoxFit.cover),
              SizedBox(width: ScreenUtil().setWidth(10)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    titel ?? "",
                    style: TextStyle(fontSize: ScreenUtil().setSp(21)),
                  ),
                  Text(
                    text ?? "",
                    style: TextStyle(fontSize: ScreenUtil().setSp(18)),
                  )
                ],
              )
            ],
          ),
          InkWell(
              onTap: () {
                print("----$titel----");
               
                 NavigatorUtils.gotoPayVip(context);
              },
              child: Container(
                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(20)),
                  width: ScreenUtil().setWidth(150),
                  height: ScreenUtil().setWidth(60),
                  decoration: BoxDecoration(
                      color: ThemeColors.colorRed,
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(30))),
                  child: Text(
                    subtitel ?? "去检测",
                    style: TextStyle(
                        color: ThemeColors.banertagBgColor,
                        fontSize: ScreenUtil().setSp(26)),
                  )))
        ],
      ),
      decoration: BoxDecoration(
          border: new Border.all(color: ThemeColors.colorF6F6F8, width: 0.8),
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(20))),
    );
  }

  Widget _vipOnlyPrivilege() {
    return Container(
        width: ScreenUtil().setWidth(720),
        height: ScreenUtil().setWidth(436),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
          image: DecorationImage(
            image: AssetImage(
              Utils.getImgPath('vip_only'),
            ),
            fit: BoxFit.contain,
          ),
        ));
  }

  Widget _privilege({@required String name, @required String titel}) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: ScreenUtil().setWidth(50)),
      child: Row(
        children: [
          SizedBox(width: ScreenUtil().setWidth(20)),
          Image(
              image: AssetImage(
                Utils.getImgPath(name),
              ),
              fit: BoxFit.cover),
          SizedBox(width: ScreenUtil().setWidth(20)),
          Text(
            titel ?? "",
            style: TextStyle(fontSize: ScreenUtil().setSp(32)),
          )
        ],
      ),
    );
  }
}
