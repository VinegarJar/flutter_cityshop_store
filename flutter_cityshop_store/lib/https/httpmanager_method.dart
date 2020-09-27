// import 'package:dio/dio.dart';
// import 'dart:async';




typedef Success = void Function(dynamic json);
typedef Fail = void Function(String error,int jsonCode);



class  HttpManagerMethod  {

// 静态变量_instance，存储唯一对象
 static HttpManagerMethod _instance;

// 工厂模式 单例
factory HttpManagerMethod() =>_getInstance();

  
static HttpManagerMethod get instance => _getInstance();
 

HttpManagerMethod._internal() {
    // 初始化
    // _instance = new HttpManagerMethod();
     //print("单利调用初始化完成------%$_instance");
}

  static HttpManagerMethod _getInstance() {
    if (_instance == null) {
      print("单利调用初始化_getInstance------%$_instance");
      _instance = new HttpManagerMethod._internal();
    }
    return _instance;
  }


  getInstan(){

    print(" 获取getInstan------%$_instance");
  } 


}


// class UserManager {

//   // 如果一个函数的构造方法并不总是返回一个新的对象的时候，可以使用factory，

//   // 比如从缓存中获取一个实例并返回或者返回一个子类型的实例

 

//   // 工厂方法构造函数

//   factory UserManager() => _getInstance();

 

//   // instance的getter方法，通过UserManager.instance获取对象

//   static UserManager get instance => _getInstance();

 

//   // 静态变量_instance，存储唯一对象

//   static UserManager _instance;

 

//   // 私有的命名式构造方法，通过它可以实现一个类可以有多个构造函数，

//   // 子类不能继承internal不是关键字，可定义其他名字

//   UserManager._internal() {

//     // 初始化

//     user = new User(false, "", "", "", "", false, "", false, "", "");

//   }

  

//   // 获取对象

//   static UserManager _getInstance() {

//     if (_instance == null) {

//       // 使用私有的构造方法来创建对象

//       _instance = new UserManager._internal();

//     }

//     return _instance;

//   }

  

//   // 用户对象

//   // User user;

// }


// class HttpManager {
//   static HttpManager _instance = HttpManager._internal();
//   Dio _dio;

//   static const CODE_SUCCESS = 200;
//   static const CODE_TIME_OUT = -1;

//   factory HttpManager() => _instance;

//   ///通用全局单例，第一次使用时初始化
//   HttpManager._internal({String baseUrl}) {
//     if (null == _dio) {
//       _dio = new Dio(
//           new BaseOptions(baseUrl: Address.BASE_URL, connectTimeout: 15000));
//       _dio.interceptors.add(new DioLogInterceptor());
// //      _dio.interceptors.add(new PrettyDioLogger());
//       _dio.interceptors.add(new ResponseInterceptors());
//     }
//   }

//   static HttpManager getInstance({String baseUrl}) {
//     if (baseUrl == null) {
//       return _instance._normal();
//     } else {
//       return _instance._baseUrl(baseUrl);
//     }
//   }

//   //用于指定特定域名
//   HttpManager _baseUrl(String baseUrl) {
//     if (_dio != null) {
//       _dio.options.baseUrl = baseUrl;
//     }
//     return this;
//   }

//   //一般请求，默认域名
//   HttpManager _normal() {
//     if (_dio != null) {
//       if (_dio.options.baseUrl != Address.BASE_URL) {
//         _dio.options.baseUrl = Address.BASE_URL;
//       }
//     }
//     return this;
//   }

//   ///通用的GET请求
//   get(api, {params, withLoading = true}) async {
//     if (withLoading) {
//       LoadingUtils.show();
//     }

//     Response response;
//     try {
//       response = await _dio.get(api, queryParameters: params);
//       if (withLoading) {
//         LoadingUtils.dismiss();
//       }
//     } on DioError catch (e) {
//       if (withLoading) {
//         LoadingUtils.dismiss();
//       }
//       return resultError(e);
//     }

//     if (response.data is DioError) {
//       return resultError(response.data['code']);
//     }

//     return response.data;
//   }

//   ///通用的POST请求
//   post(api, {params, withLoading = true}) async {
//     if (withLoading) {
//       LoadingUtils.show();
//     }

//     Response response;

//     try {
//       response = await _dio.post(api, data: params);
//       if (withLoading) {
//         LoadingUtils.dismiss();
//       }
//     } on DioError catch (e) {
//       if (withLoading) {
//         LoadingUtils.dismiss();
//       }
//       return resultError(e);
//     }

//     if (response.data is DioError) {
//       return resultError(response.data['code']);
//     }

//     return response.data;
//   }
// }

// ResultData resultError(DioError e) {
//   Response errorResponse;
//   if (e.response != null) {
//     errorResponse = e.response;
//   } else {
//     errorResponse = new Response(statusCode: 666);
//   }
//   if (e.type == DioErrorType.CONNECT_TIMEOUT ||
//       e.type == DioErrorType.RECEIVE_TIMEOUT) {
//     errorResponse.statusCode = Code.NETWORK_TIMEOUT;
//   }
//   return new ResultData(
//       errorResponse.statusMessage, false, errorResponse.statusCode);
// }
