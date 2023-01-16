import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_cityshop_store/widget/add_car_botton.dart';
import 'package:flutter_cityshop_store/widget/swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoodsDetailsPage extends StatefulWidget {
  final Map dict;
  GoodsDetailsPage({Key key, this.dict}) : super(key: key);

  @override
  _GoodsDetailsPageState createState() => _GoodsDetailsPageState();
}

class _GoodsDetailsPageState extends State<GoodsDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.mainBgColor,
      appBar: AppBar(
          backgroundColor: ThemeColors.mainColor,
          title: Text("商品详情"),
          centerTitle: true, //标题居中显示
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: Stack(children: [
        ListView(
          children: [
            SwiperDiy(jump: false, swiperDataList: [
              {"pic": widget.dict["imageUrl"]},
              {"pic": widget.dict["thumbUrl"]},
              {"pic": widget.dict["hdThumbUrl"]},
            ]),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 16),
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  Text(
                    widget.dict["goodsName"],
                    style: TextStyle(color: Colors.black, fontSize: 32.w),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10.w),
                  Text(
                    widget.dict["shortName"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: ThemeColors.titleColor,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 20.w),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.w)),
            ),
            Container(
              padding: EdgeInsets.all(20.w),
              margin: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //widget.dict["price"]
                        Text("￥" + widget.dict["price"].substring(0, 3),
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 32.w)),
                        Text(
                          "￥原价${widget.dict["marketPrice"]}",
                          style: TextStyle(
                              color: Colors.black26,
                              fontSize: 22.w,
                              decoration:
                                  TextDecoration.lineThrough), //价格横线显示样式
                        )
                      ]),
                  SizedBox(height: 20.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("销量" + widget.dict["salesTip"],
                          style: TextStyle(
                              color: ThemeColors.titleColor, fontSize: 24.sp)),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Text(
                          widget.dict["shortName"],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: ThemeColors.titleColor, fontSize: 20.w),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.w)),
            ),
            Container(
              padding: EdgeInsets.all(20.w),
              margin: EdgeInsets.only(left: 16, right: 16, top: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.w)),
              child: Column(
                children: [  
              
                
                  Image.network(
                    widget.dict["hdUrl"],
                    fit: BoxFit.fill,
                    height: 800.h,
                    width: 800.w,
                  ),
                  SizedBox(height: 20.w,child: Container(color: ThemeColors.mainBgColor,),),
                  Image.network(
                    widget.dict["imageUrl"],
                    fit: BoxFit.fill,
                    height: 800.h,
                    width: 800.w,
                  ),
             
                  
                ],
              ),
            ),
            SizedBox(height: 160.w),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: AddCarBottom(goodsDetails:true),
        )
      ]),
    );
  }
}
