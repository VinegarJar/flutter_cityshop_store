import 'package:flutter/cupertino.dart';
import 'package:flutter_cityshop_store/model/goodsinfo.dart';


class CommonProvider with ChangeNotifier {

  int currentIndex = 0;

  changeIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
  

  //缓存商品数据搜索
  List<GoodsList> lisCache = [];
  savaGoodsCache(List<GoodsList> goods) {
    goods.forEach((element) {
      lisCache.add(element);
    });
    notifyListeners();
  }

 
  



}
