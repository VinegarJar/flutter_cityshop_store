import 'package:flutter/cupertino.dart';
import 'package:flutter_cityshop_store/model/category.dart';
import 'package:flutter_cityshop_store/model/goodsinfo.dart';

class CommonProvider with ChangeNotifier {
  int selectedIndex = 0;
  int currentIndex = 0;

  //缓存商品数据搜索
  List<GoodsList> lisCache = [];
  //热搜词缓存

  changeIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }

  //存储分类列表数据
  List<Results> results = [];
  //获取分类列表数据
  List<ListItem> category = [];

  CategoryModel _model;
  savaCategory(CategoryModel data) {
    _model = data;
    results = data.results;
    category = data.category[0].list.cast<ListItem>();

    notifyListeners();
  }

  //改变子类索引
  changeCategoryList(int index) {
    category = _model.category[index].list.cast<ListItem>();
    selectedIndex = index;
    notifyListeners();
  }

  savaGoodsCache(List<GoodsList> goods) {
    goods.forEach((element) {
      lisCache.add(element);
    });
    notifyListeners();
  }

  List<GoodsList> dataCart = []; // 存储加入购物车到商品数据
  int allPrice = 0; //总价格
  int allGoodsCount = 0; //商品总数量


   
 addOrReduceAction(GoodsList goods, {bool add = true})async{

  //   var isHave= false;  //默认为没有
  //   int ival=0; //用于进行循环的索引使用

  //   allPrice=0; 
  //   allGoodsCount=0;  //把商品总数量设置为0

  //  if (add) {//首次加入购物车
  //      if (dataCart.length==0) {
  //          dataCart.add(goods);
  //          allGoodsCount=goods.count+1;
           
  //         print("首次加入购物车$allGoodsCount");

  //      } else {
  //         dataCart.forEach((model) {
  //            if (model.goodsId==goods.goodsId) {//记录单个商品数量
  //                dataCart[ival].count+=goods.count+1;
  //                isHave=true;
  //                print("单个商品数量为${dataCart[ival].count}");
  //                print("存在购物车滴购物车的商品数量$allGoodsCount");
  //            } 
  //           allGoodsCount = dataCart[ival].count; //加入到总数量
  //           ival++;
  //         });
          
  //         if(!isHave){
  //             dataCart.add(goods);
  //             allGoodsCount+= goods.count+1; //未加入购物车商品加入总数量
  //              print("未加入购物车商品加入总数量$allGoodsCount");
  //         }
          

  //      }
    
       
  //  } else {

  //  }

  //  notifyListeners();
 }



}
