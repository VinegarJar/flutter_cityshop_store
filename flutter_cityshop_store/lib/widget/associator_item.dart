import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/https/user_dao.dart';
import 'package:flutter_cityshop_store/model/associator.dart';
import 'package:flutter_cityshop_store/provide/user_provider.dart';
import 'package:flutter_cityshop_store/router/navigator_utils.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_cityshop_store/widget/alert.dart';
import 'package:flutter_cityshop_store/widget/onTop_botton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AssociatorItem extends StatelessWidget {
  final Associator model;

  const AssociatorItem({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isReal = Provider.of<UserProvider>(context, listen: false).isReal;
    bool isVIP = Provider.of<UserProvider>(context, listen: false).isVIP;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(15),
          vertical: ScreenUtil().setWidth(10)),
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(20),
          vertical: ScreenUtil().setWidth(20)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      width: ScreenUtil().setWidth(50),
                      height: ScreenUtil().setWidth(50),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            Utils.getImgPath('vip_icon'),
                          ),
                          fit: BoxFit.cover,
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setHeight(10)),
                    child: Text(
                      "会员专享产品",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(35),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setHeight(5)),
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setHeight(8)),
                    decoration: BoxDecoration(
                        color: ThemeColors.homeColor,
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(6))),
                    child: Text(
                      "会员独享",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(22),
                          color: ThemeColors.subtitlesColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      computeLongContent(model?.loanLower, model?.loanUpper),
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(38),
                          fontWeight: FontWeight.w500,
                          color: ThemeColors.loanUpperColor),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setHeight(20)),
                    child: Text(
                      timerContent(
                          model?.loanPeriodLower, model?.loanPeriodUpper),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(38),
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ),
                  OnTopBotton(
                    callBack: () {
                      if (isReal) {
                        if (isVIP) {
                          jumpWebView(context);
                        } else {
                          Alert.showAssociatorSheet(context: context, gotoVipPressed: () { 
                             NavigatorUtils.gotoVipPages(context);
                           });
                           
                        }
                      } else {
                        Alert.showDialogSheet(context: context);
                      }
                    },
                    title: isVIP ? "立即申请" : "立即解锁",
                    widget: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(35)),
                      height: ScreenUtil().setWidth(60),
                      decoration: BoxDecoration(
                          color: ThemeColors.toastColor,
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setWidth(28))),
                      child: Text("立即解锁",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(30),
                            color: ThemeColors.whiteColor, //35,17,0
                          )),
                    ),
                  )
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text("VIP独享额度|放款率高达95%",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(32),
                      color: ThemeColors.titleColor,
                    )),
              ),
              Container(
                child: Text("24小时放款",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(32),
                      color: ThemeColors.titleColor,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  computeLongContent(var minimum, var maximum) {
    String min;
    if (minimum != null && minimum > 10000) {
      min = (minimum / 10000).truncate().toString() + "万";
    } else {
      min = minimum?.toString() ?? "0";
    }
    String max;
    if (maximum != null && maximum > 10000) {
      max = (maximum / 10000).truncate().toString() + "万";
    } else {
      max = maximum?.toString() ?? "0";
    }
    return (min + "~" + max);
  }

  timerContent(var loanPeriodLower, var loanPeriodUpper) {
    if (loanPeriodLower.toString().length > 3) {
      return ("3" + "~" + "12月");
    }
    return (loanPeriodLower.toString() +
        "~" +
        loanPeriodUpper.toString() +
        "月");
  }

  computedownload(var applyNum) {
    return (applyNum?.toString() ?? "0") + "人已下载";
  }

  void jumpWebView(BuildContext context) async {
    UserDao.jumpWebView(context, model.productId);
  }
}
