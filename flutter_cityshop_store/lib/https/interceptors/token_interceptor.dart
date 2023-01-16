// import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';
import 'package:flutter_cityshop_store/common/local/local_storage.dart';

/*
* @TokenInterceptors:  Token拦截器
* @return {token} token信息
*/
class TokenInterceptors extends InterceptorsWrapper {
  String _token;

  @override
  onRequest(RequestOptions options, handler) async {
    // print("授权码拦截器----${options.path}");
    // print('授权码拦截器请求头: ${options.headers}');
    //授权码
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
         _token = authorizationCode;
      }
    }
    if (_token != null) {
      options.headers["app_token"] = _token;
    }
    return super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, handler) async {
    return super.onResponse(response, handler);
  }

  ///清除授权
  clearAuthorization() {
    this._token = null;
    LocalStorage.remove(Config.TOKEN_KEY);
  }

  ///获取授权token
  getAuthorization() async {
    String token = await LocalStorage.get(Config.TOKEN_KEY);
    return token;
  }
}
