import 'package:dio/dio.dart';
import 'dart:async';

typedef Success = void Function(dynamic json);
typedef Fail = void Function(String error,int jsonCode);



// ignore: camel_case_types
class  httpUtil_method  {


 static const String API_PREFIX = 'http://v.jspang.com:8088/baixing/';

  static Dio dio;



  // ignore: missing_return
  static Future requestGetWithPath(String url,{parameters, method}) async{

     Dio dio = getInstance();

     try {
      Response response = await dio.get(url,queryParameters:parameters);
      if (response.statusCode == 200) {
           print('响应数据：' + response.toString());
           return response.data;
      } else {
        throw Exception(
            'statusCode:${response.statusCode}---后端接口出现异常，请检测代码和服务器情况.........');
      }
    } on DioError catch (e) {
        print('请求出错：' + e.toString());
        
    }

 }

 static getInstance() {
    if (dio == null) {
      dio = createInstanceDio();
    }
    return dio;
  }

 static  Dio createInstanceDio() {

     var options = BaseOptions(
        connectTimeout: 3000,
        receiveTimeout: 3000,// 响应流上前后两次接受到数据的间隔，单位为毫秒。
        sendTimeout: 3000,
        // contentType: "application/x-www-form-urlencoded",
        responseType: ResponseType.json ,
        //headers: ,
        baseUrl: API_PREFIX,
      );
 
     dio = new Dio(options);
     return dio;
  }


}
