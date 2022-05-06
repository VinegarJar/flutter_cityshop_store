import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/utils/themecolors.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

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
  InAppWebViewController webView;

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
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
            crossPlatform: InAppWebViewOptions(
                mediaPlaybackRequiresUserGesture: false,
                debuggingEnabled: true,
                useOnDownloadStart: true),
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            webView = controller;
          },
          onLoadStart: (InAppWebViewController controller, String url) {},
          onLoadStop: (InAppWebViewController controller, String url) {},
          onDownloadStart:
              (InAppWebViewController controller, String url) async {
            print("开始下载--------------->$url");
            launch(url);
          },
          onReceivedServerTrustAuthRequest: (controller, challenge) async {
            return ServerTrustAuthResponse(
                action: ServerTrustAuthResponseAction.PROCEED);
          },
          androidOnPermissionRequest: (InAppWebViewController controller,
              String origin, List<String> resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          }),
    ));
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
