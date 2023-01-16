import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/https/user_dao.dart';
import 'package:flutter_cityshop_store/model/advert.dart';
import 'package:flutter_cityshop_store/provide/user_provider.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/utils/utils.dart';
import 'package:flutter_cityshop_store/widget/alert.dart';
import 'package:flutter_cityshop_store/widget/messagebar.dart';
import 'package:flutter_cityshop_store/widget/onTop_botton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeBanner extends StatelessWidget {
  final List bannner;
  final bool jump;
  final VoidCallback callBack;
  HomeBanner({
    @required this.bannner,
    this.jump = true,
    this.callBack,
  });

  void jumpToRealName(BuildContext context, var productId) async {
    bool isReal = Provider.of<UserProvider>(context, listen: false).isReal;

    if (isReal) {
      UserDao.jumpWebView(context, productId);
    } else {
      Alert.showDialogSheet(
          context: context,
          onPressed: (Map<String, dynamic> result) {
            print("弹框关闭 $result");
            //MessageBar messagebar
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(465),
        width: ScreenUtil().setWidth(750),
        margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(15),
            vertical: ScreenUtil().setWidth(20)),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            Advert model = bannner.length > 0 ? bannner[index] : null;
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: (model?.bannerImgUrl != null)
                          ? NetworkImage(model?.bannerImgUrl)
                          : ExactAssetImage(Utils.getImgPath('placeholderImg')),
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  MessageBar(),
                  _titleWidget(model),
                  Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                    child: Text(model?.longContent ?? "",
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(32),
                          color: ThemeColors.titleColor,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(15),
                        vertical: ScreenUtil().setWidth(20)),
                    child: Text(
                      model != null
                          ? computeLongContent(
                              model?.loanLower, model?.loanUpper)
                          : "",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(60),
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  model != null
                      ? OnTopBotton(
                          callBack: () {
                            jumpToRealName(context, model.productId);
                          },
                          title: "立即激活",
                          widget: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(40),
                            ),
                            height: ScreenUtil().setWidth(88),
                            decoration: BoxDecoration(
                                color: ThemeColors.homemainColor,
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().setWidth(44))),
                            child: Text("立即激活",
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(32),
                                  color: ThemeColors.whiteColor, //35,17,0
                                )),
                          ),
                        )
                      : Container()
                ],
              ),
            );
          },

          itemCount: bannner.length > 0 ? bannner.length : 1,
          scrollDirection: Axis.horizontal,
          autoplay: false,
          onIndexChanged: (index) {},
          scale: 0.95, // 两张图片之间的间隔
          onTap: (index) {
            print('点击了第$index个');
          },
          // 展示窗口模式viewportFraction: 0.8,
        ));
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

  Widget _titleWidget(Advert model) {
    return model != null
        ? Container(
            margin: EdgeInsets.only(top: ScreenUtil().setWidth(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (model?.productUrl != null)
                    ? Container(
                        width: ScreenUtil().setWidth(50),
                        height: ScreenUtil().setHeight(50),
                        decoration: BoxDecoration(
                            color: ThemeColors.mainBgColor,
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(5))),
                        child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: model?.productUrl,
                            fit: BoxFit.fill))
                    : Container(),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setHeight(20)),
                  child: Text(
                    model?.productName ?? "",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(38),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                  decoration: BoxDecoration(
                      color: ThemeColors.homeColor,
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(5))),
                  child: Text(
                    model?.longContent ?? "新口子",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(23),
                        color: ThemeColors.subtitlesColor),
                  ),
                )
              ],
            ),
          )
        : Container();
  }
}
