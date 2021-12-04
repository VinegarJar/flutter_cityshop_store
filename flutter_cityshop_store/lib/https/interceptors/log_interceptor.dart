import 'package:dio/dio.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';

/*
 * Log 拦截器
 * on 2021/11/23.
 */

class LogsInterceptors extends InterceptorsWrapper {
  
  @override
  onRequest(RequestOptions options, handler) async {
    if (Config.DEBUG) {
      print("请求url：${options.path} ${options.method}");
      options.headers.forEach((k, v) => options.headers[k] = v ?? "");
      print('请求头: ' + options.headers.toString());
      if (options.data != null) {
        print('请求参数: ' + options.data.toString());
      }
    }
    try {
      var data;
      if (options.data is Map) {
        data = options.data;
      } else {
        data = Map<String, dynamic>();
      }
      var map = {
        "header:": {...options.headers},
      };
      if (options.method == "POST") {
        map["data"] = data;
      }
      print('Log拦截器请求成功：' + options.data.toString());
    } catch (e) {
      print('Log拦截器请求出错：' + e.toString());
    }
    return super.onRequest(options, handler);
  }


  @override
  onResponse(Response response, handler) async {
    return super.onResponse(response, handler);
  }

  @override
  onError(DioError err, handler) async {
    if (Config.DEBUG) {
      print('请求异常: ' + err.toString());
      print('请求异常信息: ' + (err.response?.toString() ?? ""));
    }
    return super.onError(err, handler);
  }

}
