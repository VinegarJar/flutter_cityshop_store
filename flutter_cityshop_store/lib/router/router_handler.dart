import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_cityshop_store/pages/index_page.dart';


Handler rootRouteHandler =Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
     return IndexPages();
  }
);



