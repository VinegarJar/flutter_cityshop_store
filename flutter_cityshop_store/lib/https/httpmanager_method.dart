import 'package:dio/dio.dart';
//flutter clean 清理

typedef onSuccess = void Function(dynamic data);
typedef onError = void Function(String error);

const httpHeaders = {
  'Content-Type': 'application/json',
  'X-LC-Id': 'a4Cj1Hm5aMrdhob6xGw71B5A-gzGzoHsz',
  'X-LC-Key': 'XQaL1tUQC0DCQxBA9fpoR21C',
};


const hotcommendUrl = "App/Api/homeHotCommendGoods"; //首页热卖推荐
const categoryUrl = "App/Index/shopSecondCategory"; //分类列表数据
const goodsList =  "v2/goods";//首页列表数据


class HttpManagerMethod {
  static Dio _dio;

  /// default options
  static const String BASE_URL = 'http://mock-api.com/Rz3ambnM.mock/';

  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 10000;

  //http request methods
  static const String GET = 'get';

  // 静态变量_instance，存储唯一对象
  static HttpManagerMethod _instance;

  // 工厂模式 单例
  factory HttpManagerMethod() => _getInstance();

  //获取单利
  static HttpManagerMethod get instance => _getInstance();

  static HttpManagerMethod _getInstance() {
    if (_instance == null) {
      _instance = new HttpManagerMethod._internal();
    }
    return _instance;
  }
  
  //初始化通用全局单例，第一次使用时初始化
  HttpManagerMethod._internal();

  static Dio createInstance() {
    if (_dio == null) {
      _dio = new Dio(new BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT, // 响应流上前后两次接受到数据的间隔，单位为毫秒。
        responseType: ResponseType.plain,
      ));
    }
    return _dio;
  }

  Response response;
  //future里面有几个函数：then：异步操作逻辑在这里写。whenComplete：异步完成时的回调。catchError：捕获异常或者异步出错时的回调。
  /** 
   * Future<Null> future = new Future(() => null);
    await  future.then((_){
      print("then");
    }).then((){
      print("whenComplete");
    }).catchError((_){
      print("catchError");
    });
   */
  Future  requestWithMetod(api, {parameters, method, String baseUrl}) async {
    
    Options options = Options(method: method);
    options.headers = httpHeaders;
    Dio dio = createInstance();

    if (baseUrl!= null) {//重定向baseUrl 用于指定特定域名
         dio.options.baseUrl = baseUrl;
     } 
    parameters = parameters ?? {};
    method = method ?? GET;

    /// 请求处理
    parameters.forEach((key, value) {
      if (api.indexOf(key) != -1) {
        api = api.replaceAll(':$key', value.toString());
      }
    });

    /// 打印:请求地址-请求方式-请求参数
    /// 
    print('请求地址-请求参数-请求方式\n【' +
        api +"\n"+
        parameters.toString()+"\n"+
        method+
        '】');
    var result;
    try {
      Response response =
          await dio.request(api, data: parameters, options: options);
      print('响应数据：' + response.data);
      if (response.statusCode == 200) {
        result = response.data;
      } else {
        throw Exception('statusCode:${response.statusCode}-请检测代码和服务器情况..');
      }
    } on DioError catch (e) {
      print('请求出错：' + e.toString());
    }
    return result;
  }
}
