import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';
import 'package:flutter_cityshop_store/https/httpRequest_method.dart';
import 'package:flutter_cityshop_store/model/appconfig.dart';
import 'package:flutter_cityshop_store/provide/user_provider.dart';
import 'package:flutter_cityshop_store/router/navigator_utils.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_cityshop_store/widget/alert.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

typedef OnPressedResults = void Function(dynamic result);

class Associator extends StatefulWidget {
  Associator({Key key}) : super(key: key);

  @override
  _AssociatorState createState() => _AssociatorState();
}

class _AssociatorState extends State<Associator> {
  List<AppConfig> dataConfig = [];

  final dataSource = [
    {"title": "黑名单检测", "url": Utils.getImgPath('blacklist'), "index": 0},
    {"title": "下款快", "url": Utils.getImgPath('payments'), "index": 1},
    {"title": "通过率高", "url": Utils.getImgPath('pass'), "index": 2},
    {"title": "急速放款", "url": Utils.getImgPath('rapid'), "index": 3}
  ];

  @override
  void initState() {
    super.initState();
    requstAppConfig();
  }

  void requstAppConfig() async {
    HttpRequestMethod.instance
        .requestWithMetod(Config.getAppShowConfig, null)
        .then((res) {
      List<Map> list = (res.data as List).cast();
      final List dataSource =
          list.map((data) => AppConfig.fromJson(data)).toList();
      print("----获取权益请求$dataSource");

      setState(() {
        dataConfig = dataSource;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_wrapList(dataSource, context), _checkList(context)],
      ),
    );
  }

  Widget _checkList(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
            vertical: ScreenUtil().setWidth(20)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          InkWell(
              onTap: () {
                print("信用检测------");
                chckRealAndVip(context, "优化信用");
              },
              child: Container(
                  width: ScreenUtil().setWidth(340),
                  height: ScreenUtil().setWidth(200),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setWidth(15)),
                    image: DecorationImage(
                      image: AssetImage(
                        Utils.getImgPath('credit'),
                      ),
                      fit: BoxFit.contain,
                    ),
                  ))),
          InkWell(
              onTap: () {
                print("会员专享------");
                chckRealAndVip(context, "会员专享");
              },
              child: Container(
                  width: ScreenUtil().setWidth(340),
                  height: ScreenUtil().setWidth(200),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setWidth(15)),
                    image: DecorationImage(
                      image: AssetImage(
                        Utils.getImgPath('associator'),
                      ),
                      fit: BoxFit.contain,
                    ),
                  ))),
        ]));
  }

  Widget _wrapList(List dataSource, BuildContext context) {
    List<Widget> listWidget = dataSource.map((val) {
      return InkWell(
          onTap: () {
            print("专属服务专区---$val---");
            chckRealAndVip(context, val["title"]);
          },
          child: Container(
              width: MediaQuery.of(context).size.width / 4,
              margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(20)),
              child: Column(children: [
                Image(
                    width:ScreenUtil().setWidth(100) ,
                    height:ScreenUtil().setWidth(100) ,
                    image: AssetImage(
                      val["url"],
                    ),
                    fit: BoxFit.cover),
                SizedBox(
                  height: ScreenUtil().setWidth(20),
                ),
                Text(
                  val["title"],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: ThemeColors.appliedColor,
                      fontSize: ScreenUtil().setSp(34)),
                ),
                SizedBox(
                  height: ScreenUtil().setWidth(10),
                ),
              ])));
    }).toList();
    return Row(
        mainAxisAlignment: MainAxisAlignment.center, children: listWidget);
  }

  void chckRealAndVip(context, title) {
    bool isReal = Provider.of<UserProvider>(context, listen: false).isReal;

    print("点击---$title---");
    if (isReal) {
      getJumpUrl(context, title);
    } else {
      Alert.showDialogSheet(context: context);
    }
  }

  void getJumpUrl(context, title) {
    
    Iterable<AppConfig> dataSource = dataConfig
        .where((model) => model.showAreaName.contains(title))
        .toList();
    if (dataSource.length > 0) {
      AppConfig model = dataSource.first;
      print("-------获取地址----$dataSource");
      print("-------获取地址----${model.showArea}");
      NavigatorUtils.goWebView(
        context,
        model.showArea,
        model.showAreaName
      );
    } else {
   
    }
  }

}
