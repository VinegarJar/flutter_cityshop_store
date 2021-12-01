import 'package:dio/dio.dart';
import 'package:flutter_cityshop_store/https/code.dart';
import 'package:flutter_cityshop_store/https/result_data.dart';

/*
 * Response拦截器
 * on 2019/3/23.
 */

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response, handler) async {
    RequestOptions option = response.requestOptions;
    var value;
    try {
      Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);

      var header = response.headers[Headers.contentTypeHeader];
      if ((header != null && header.toString().contains("text"))) {
        value = new ResultData(data["result"], true, Code.SUCCESS);
      } else if (response.statusCode >= 200 && response.statusCode < 300) {
        value =
            new ResultData(data["result"], true, Code.SUCCESS, headers: response.headers);
      }
    } catch (e) {
      print("ResponseInterceptor" + e.toString() + option.path);
      value = new ResultData(response.data, false, response.statusCode,
          headers: response.headers);
    }
    response.data = value;
    return handler.next(response);
  }
}
