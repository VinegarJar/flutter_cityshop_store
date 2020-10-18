import 'package:flutter/cupertino.dart';
import 'package:flutter_cityshop_store/model/goodsinfo.dart';

class CarProvider with ChangeNotifier {

   List<GoodsList> shopCart=[]; //购物车商品 
   
   GoodsList item;

   int allGoodsCount =0;  //商品总数量

  addOrReduceAction(GoodsList model, {bool isAdd = true} )async{
     
       print("商品model===$model");
       print('the thing I want to see in the console is: ${model.goodsName}');

 }



}
