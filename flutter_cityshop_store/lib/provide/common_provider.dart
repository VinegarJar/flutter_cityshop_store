import 'package:flutter/cupertino.dart';
import 'package:flutter_cityshop_store/model/category.dart';
import 'package:flutter_cityshop_store/model/goodsinfo.dart';




class CommonProvider with ChangeNotifier {

  int selectedIndex = 0;
  int currentIndex = 0;


  //缓存商品数据搜索
  List <GoodsList>lisCache =  []; 
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
  savaCategory(CategoryModel data){
    
     _model = data;
     results = data.results;
     category = data.category[0].list.cast<ListItem>();    

     notifyListeners();  
  }


  //改变子类索引
  changeCategoryList(int index){

      category = _model.category[index].list.cast<ListItem>();
      selectedIndex = index;     
      notifyListeners();
    }  



  savaGoodsCache(List <GoodsList> goods){
     
    goods.forEach((element) {
      
       lisCache.add(element);
    }); 
    
  //  lisCache.addAll(goods);
   notifyListeners();

  } 

   

}
