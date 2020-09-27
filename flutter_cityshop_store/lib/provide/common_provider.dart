
import 'package:flutter/cupertino.dart';

class CommonProvider with ChangeNotifier {


  int currentIndex=0;
  
  changeIndex(int newIndex){
    currentIndex=newIndex;
    notifyListeners();
  }



}