
import 'package:dio/dio.dart';
import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/https/httpManager_method.dart';
// import 'package:flutter_cityshop_store/https/httpmanager_method.dart'; 

class HomePages extends StatefulWidget {
  HomePages({Key key}) : super(key: key);

  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {

  @override
  void initState() {
  
    super.initState();
    
   
    
    //  HttpManagerMethod.instance.requestWithMetod(
    //    categoryUrl,
    //    method: "post").then((value) {

    //   print("-------------------------------------");
    //  });

      HttpManagerMethod.instance.requestWithMetod(
       goodsList,
       parameters: {'size': '50', 'page': 3},
       method: "get",baseUrl:"http://apiv2.yangkeduo.com/" ).then((value) {

      print("-------------------------------------");
     });


  } 


 void _getCarouselData() async {

   try {
   // print('开始获取首页数据...............');

    Response response;
    Dio dio = new Dio();
    
    // dio.options.contentType = "application/x-www-form-urlencoded";
    // var formData = {'lon': '115.02932', 'lat': '35.76189'};
    response = await dio.get("http://mock-api.com/Rz3ambnM.mock/App/Api/homeBanner");

         var result = response.data;

         print('开始获取首页数据...............$result');
    //response = await dio.post("/test", data: {"id": 12, "name": "wendu"});
    // if (response.statusCode == 200) {
    //   return response.data;
    // } else {
    //   throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    // }
  } catch (e) {
    return print('ERROR:======>${e}');
  }
 }


  @override
  Widget build(BuildContext context) {

    return Text("我是第一个页面"); 
    // return Scaffold(
    // backgroundColor: Colors.orange,  
    // appBar: AppBar(
    //   backgroundColor: Colors.yellow,
    //       title: Text("首页"),
    //       centerTitle: true, //标题居中显示
    //     ),
    // body: Text("我是第一个页面"),    
    // );
        
  }
}