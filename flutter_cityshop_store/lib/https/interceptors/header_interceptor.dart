import 'package:dio/dio.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';

class HeaderInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options, handler) async {
    ///超时
    options.connectTimeout = 30000;
    options.receiveTimeout = 30000;
    return super.onRequest(options, handler);
  }
}
