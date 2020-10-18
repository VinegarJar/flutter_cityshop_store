import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AddCarBottom extends StatefulWidget {
  AddCarBottom({Key key}) : super(key: key);

  @override
  _AddCarBottomState createState() => _AddCarBottomState();
}

class _AddCarBottomState extends State<AddCarBottom> {
  

  @override
  Widget build(BuildContext context) {

  //  final allGoodsCount = Provider.of<CommonProvider>(context).allGoodsCount;   
  //  final allPrice = Provider.of<CommonProvider>(context).allPrice;  
    double allPrice = 0;
    return Container(
        height: 100.w,
        margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 30.w),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(50.w)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Stack(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    print("点击购物车");
                  },
                  child: Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                        color: ThemeColors.mainColor,
                        borderRadius: BorderRadius.circular(50.w)),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.shopping_cart,
                      size: 26,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 55.w,
                  top: 15.w,
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Text(
                      '99',
                      style: TextStyle(
                          color: ThemeColors.mainColor,
                          fontSize: ScreenUtil().setSp(16)),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left:10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     allPrice>0?allPrice:'未选购商品',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(32)),
                    ),
                    Text(
                      '另需配送费¥9',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(18)),
                    ),
                  ],
                ),
              ),
            ),
          
            InkWell(
              
              onTap: () async {
                // await Provide.value<CartProvide>(context).remove();
                print("点击马上购买");
              },
              child:
              
              allPrice > 0?
              Container(
                width: 200.w,
                height: 100.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: ThemeColors.mainColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.w),
                      bottomRight: Radius.circular(50.w),
                    )),
                child: Text(
                      '去结算',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(32)),
                    ),
              ): 
              Container(
                width: 200.w,
                height: 100.w,
                decoration: BoxDecoration(
                    color: ThemeColors.color999999,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.w),
                      bottomRight: Radius.circular(50.w),
                    )),
                child: 
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¥20起送',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(32)),
                    ),
                    Text(
                      '未点必选品',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(18)),
                    ),
                  ],
                ),
              )
            ),
          ],
        ));
  }
}
