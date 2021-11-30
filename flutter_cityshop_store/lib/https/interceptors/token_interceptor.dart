import 'dart:convert';

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
    try {
      var responseJson = response.data;
      // var responseJson = new Map<String, dynamic>.from(response.data);

      if (response.statusCode == 200) {
        // var result = json.decode(response.data.toString());

        print("Token拦截器---------${responseJson.code}");
      }

      if (response.statusCode == 201 && responseJson["token"] != null) {
        // _token = 'token ' + responseJson["token"];
        // await LocalStorage.save(Config.TOKEN_KEY, _token);
      }
    } catch (e) {
      print(e);
    }
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
    if (token == null) {
      //读取
    } else {
      this._token = token;
      return token;
    }
  }
}
