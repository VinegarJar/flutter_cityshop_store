import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/router/routes.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  final bool jump;
  SwiperDiy({Key key, this.jump = true,this.swiperDataList,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(265),
        width: ScreenUtil().setWidth(750),
        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("${swiperDataList[index]['pic']}"),
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            );
          },

          itemCount: swiperDataList.length,
          pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
            color: Colors.white,
            activeColor: ThemeColors.mainColor,
            // 原点字体大小 size: ScreenUtil().setSp(30),
            // 当前的指示字体大小activeSize: ScreenUtil().setSp(35),
          )),
          scrollDirection: Axis.horizontal,
          autoplay: true,
          onIndexChanged: (index) {
            //  print('onIndexChanged$index个');
          },
          scale: 0.95, // 两张图片之间的间隔
          onTap: (index) {
            print('点击了第$index个');
            if(jump){
                Routes.navigateTo(
                context,
                Routes.webView,
                params: {
                  'title': swiperDataList[index]['title'],
                  'url': swiperDataList[index]['link'],
                },
              );
            }
           
          },
          // 展示窗口模式viewportFraction: 0.8,
        ));
  }
}
