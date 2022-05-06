import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:install_plugin_v2/install_plugin_v2.dart';

class FlutterWebPage extends StatefulWidget {
  final String resultUrl;
  final String title;
  FlutterWebPage({Key key, @required this.resultUrl, @required this.title})
      : super(key: key);

  @override
  _FlutterWebPageState createState() => _FlutterWebPageState();
}

//https://cloud.tencent.com/developer/ask/sof/736876/answer/1078726 webveiwe下载apk参考地址
class _FlutterWebPageState extends State<FlutterWebPage> {
  // InAppWebViewController webView;

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: ThemeColors.titlesColor),
            onPressed: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
        backgroundColor: ThemeColors.homemainColor, //标题居中显示
      ),
      body: InAppWebView(
        initialUrl: widget.resultUrl,
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(useOnDownloadStart: true),
        ),
        onDownloadStart: (InAppWebViewController controller, String url) async {
          final request = await Permission.storage.request();
          if (request == PermissionStatus.granted) {
            updateAppEx(url);
          } else {
            print("授权成功失败-->$request");
            launch(url);
          }
        },
        // onWebViewCreated: (InAppWebViewController controller) {
        //   webView = controller;
        // },
        // onLoadStart: (InAppWebViewController controller, String url) {},
        // onLoadStop: (InAppWebViewController controller, String url) {},
        // onDownloadStart: (InAppWebViewController controller, String url) async {

        // },
        // onReceivedServerTrustAuthRequest: (controller, challenge) async {
        //   return ServerTrustAuthResponse(
        //       action: ServerTrustAuthResponseAction.PROCEED);
        // },
        // androidOnPermissionRequest: (InAppWebViewController controller,
        //     String origin, List<String> resources) async {
        //   return PermissionRequestResponse(
        //       resources: resources,
        //       action: PermissionRequestResponseAction.GRANT);
        // }
      ),
    ));
  }

  String _apkFilePath;

  /// 下载并安装APK文件
  void updateAppEx(String url) async {
    try {
      File _apkFile = await downloadAndroid(url);
      _apkFilePath = _apkFile.path;

      if (_apkFilePath.isEmpty) {
        print('make sure the apk file is set');
        return;
      }
    } catch (e) {
      print('下载APK失败: ${e.toString()}');
    }
  }

  void installApk(File path) async {
    try {
      InstallPlugin.installApk(path.path, 'com.store.applyslug').then((result) {
        print('install apk成功 $result');
      }).catchError((error) {
        print('install apk 失败error: $error');
      });
    } catch (e) {
      print('安装APK失败: ${e.toString()}');
    }
  }

  String getFlieName(String url) {
    try {
      if (url != null) {
        List<String> lstStr = url.split('/');
        return lstStr.last;
      }
    } catch (e) {
      print("获取下载文件名错误：$e");
    }
    return "";
  }

  double _dPercent = 0;

  /// 下载安卓更新包
  // ignore: missing_return
  Future<File> downloadAndroid(String url) async {
    String fileName = getFlieName(url);
    if (fileName != "") {
      /// 创建存储文件
      Directory storageDir = await getExternalStorageDirectory();
      String storagePath = storageDir.path;

      String filePath = '$storagePath/$fileName';
      File file = new File(filePath);
      try {
        Dio dio = new Dio();
        // file.createSync();
        Response response = await dio.download(url, filePath,
            onReceiveProgress: (int count, int total) {
          //进度
          var d = (count / total).toStringAsFixed(2);
          _dPercent = double.parse(d);
          print((_dPercent * 100).toString() + "%");
          print("现在进度： 当前：$count  总：$total");

          EasyLoading.showProgress(_dPercent,
              status: '下载中...', maskType: EasyLoadingMaskType.black);
        });
        if (response.data.statusCode == 200) {
          print('文件下载完成！:${response.data}');
          print('文件下载完成路径file:$file');
          EasyLoading.dismiss();
          installApk(file);
        }
        return file;
      } catch (e) {
        EasyLoading.dismiss();
        print('下载APK失败: ${e.toString()}');
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
