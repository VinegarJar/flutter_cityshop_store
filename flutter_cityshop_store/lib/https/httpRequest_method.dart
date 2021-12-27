import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:flutter_cityshop_store/https/code.dart';
import 'package:flutter_cityshop_store/https/interceptors/error_interceptor.dart';
import 'package:flutter_cityshop_store/https/interceptors/header_interceptor.dart';
import 'package:flutter_cityshop_store/https/interceptors/log_interceptor.dart';
import 'package:flutter_cityshop_store/https/interceptors/response_interceptor.dart';
import 'package:flutter_cityshop_store/https/interceptors/token_interceptor.dart';
import 'package:flutter_cityshop_store/https/result_data.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';

const httpHeaders = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'app_token': 'token'
};

class HttpRequestMethod {
  static Dio _dio = new Dio(); // 使用默认配置

  //http request methods
  static const String GET = 'get';
  // 静态变量_instance，存储唯一对象
  static HttpRequestMethod _instance;

  // 工厂模式 单例
  factory HttpRequestMethod() => _getInstance();

  //获取单利
  static HttpRequestMethod get instance => _getInstance();

  static HttpRequestMethod _getInstance() {
    if (_instance == null) {
      _instance = new HttpRequestMethod._internal();
    }
    return _instance;
  }

  final TokenInterceptors _tokenInterceptors = new TokenInterceptors();

  //初始化通用全局单例，第一次使用时初始化
  HttpRequestMethod._internal() {
    print('初始化通用全局单例--我是命名构造函数');
    _dio.interceptors.add(new HeaderInterceptors());
    _dio.interceptors.add(_tokenInterceptors);
    _dio.interceptors.add(new LogsInterceptors());
    _dio.interceptors.add(new ErrorInterceptors());
    _dio.interceptors.add(new ResponseInterceptors());
  }

  Future requestWithMetod(url, params,
      {Map<String, dynamic> header, Options option, String baseUrl}) async {
    Map<String, dynamic> headers = new HashMap();
    Map dict = Map<String, dynamic>.from(params);
    if (baseUrl != null) {
      //重定向baseUrl 用于指定特定域名
      _dio.options.baseUrl = baseUrl;
    } else {
      _dio.options.baseUrl = Config.baseURL;
    }

    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "post");
    }

    /// 请求处理Error信息
    resultError(DioError e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(
            statusCode: 666, requestOptions: RequestOptions(path: url));
      }
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      return new ResultData(
          Code.errorHandleFunction(errorResponse.statusCode, e.message, false),
          false,
          errorResponse.statusCode);
    }

    Response response;
    try {
      response = await _dio.request(url, data: dict, options: option);
    } on DioError catch (e) {
      return resultError(e);
    }
    if (response.data is DioError) {
      return resultError(response.data);
    }
    return response.data;
  }

  ///清除授权
  clearAuthorization() {
    _tokenInterceptors.clearAuthorization();
  }

  ///获取授权token
  getAuthorization() async {
    return _tokenInterceptors.getAuthorization();
  }
}
