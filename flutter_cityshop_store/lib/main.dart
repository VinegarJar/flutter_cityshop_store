import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_cityshop_store/provide/car_provider.dart';
import 'package:flutter_cityshop_store/provide/common_provider.dart';
import 'package:flutter_cityshop_store/router/routes.dart';
import 'package:provider/provider.dart';
import 'dart:io';

Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());

  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      //这是设置状态栏的图标和字体的颜色
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

  //asyncFibonacci函数里会创建一个isolate，并返回运行结果
  // print(await asyncFibonacci(20));
  // sendPortIsolate();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Routes.router = router;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CommonProvider()),
          ChangeNotifierProvider(create: (_) => CarProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false, //关闭显示debug模式
          initialRoute: '/', //配置路由
          onGenerateRoute: Routes.router.generator, //配置路由引用
          title: '千城小店',
          theme: ThemeData(primaryColor: Colors.white, fontFamily: 'Raleway'),
        ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  //一种跳过SSL认证问题并解决Image.network(url)问题的方法是使用以下代码：
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

sendPortIsolate() async {
  //1.创建一个和isoLate环境交流的Port
  var receivePort = new ReceivePort();
  //2.创建一个隔离isolate并且提供用于回执的sendPort,receivePort.sendPort是一个给当前receive发消息的sendPort
  await Isolate.spawn(speak, receivePort.sendPort);
  //5.现在需要一个sendPort给isolate发送消息
  SendPort sendPort = await receivePort.first;
  //6. 利用sendPort给isoLate发送一个消息
  var resultFromIsoLate = await sendMessage2IsoLate(sendPort, 'apple');
  //8.打印来自于isolate的执行结果
  // ignore: unnecessary_brace_in_string_interps
  print('sendPort发送一个消息$resultFromIsoLate');
  resultFromIsoLate = await sendMessage2IsoLate(sendPort, 'banana');
  print('sendPort发送第二个个消息$resultFromIsoLate');
}

//3.创建用于在新isolate执行的函数speak
speak(SendPort sendPort) async {
  //4.现在提供给主isolate一个用于给子isolate发消息的sendPort
  var receivePort = new ReceivePort();
  sendPort.send(receivePort.sendPort);

  //单次读取
  // var msgFromMainIsoLate = await receivePort.first;
  // var msg = msgFromMainIsoLate[0];
  // SendPort replyTo = msgFromMainIsoLate[1];
  // replyTo.send("单次读取 " + msg);

  //7. 读取receivePort并且回传消息, receivePort看起来是一个可迭代器
  await for (var r in receivePort) {
    print('读取receivePort并且回传消息$r');
    var msg = r[0];
    SendPort replyTo = r[1];
    replyTo.send("i like eat " + msg);
  }
}
//如果需要关闭，使用receivePort.close

//发送一条消息给isolate
Future sendMessage2IsoLate(SendPort sendPort, String msg) {
  ReceivePort receivePort = ReceivePort();
  sendPort.send([msg, receivePort.sendPort]);
  return receivePort.first;
}

//Flutter的isolate异步线程机制及使用实战详解 完整的Isolate创建和使用示例
//这里以计算斐波那契数列为例，返回的值是Future，因为是异步的
Future<dynamic> asyncFibonacci(int n) async {
  //首先创建一个ReceivePort，为什么要创建这个？
  //因为创建isolate所需的参数，必须要有SendPort，SendPort需要ReceivePort来创建
  final response = new ReceivePort();
  //开始创建isolate,Isolate.spawn函数是isolate.dart里的代码,_isolate是我们自己实现的函数
  //_isolate是创建isolate必须要的参数。
  await Isolate.spawn(_isolate, response.sendPort);
  //获取sendPort来发送数据
  final sendPort = await response.first as SendPort;
  //接收消息的ReceivePort
  final answer = new ReceivePort();
  //发送数据
  sendPort.send([n, answer.sendPort]);
  //获得数据并返回
  return answer.first;
}

//创建isolate必须要的参数
void _isolate(SendPort initialReplyTo) {
  final port = new ReceivePort();
  //绑定
  initialReplyTo.send(port.sendPort);
  //监听
  port.listen((message) {
    //获取数据并解析
    final data = message[0] as int;
    final send = message[1] as SendPort;
    //返回结果
    send.send(syncFibonacci(data));
  });
}

int syncFibonacci(int n) {
  return n < 2 ? n : syncFibonacci(n - 2) + syncFibonacci(n - 1);
}
