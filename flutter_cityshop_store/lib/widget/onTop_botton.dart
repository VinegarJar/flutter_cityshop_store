import 'package:flutter/material.dart';
import 'package:flutter_cityshop_store/common/config/config.dart';
import 'package:flutter_cityshop_store/common/local/local_storage.dart';
import 'package:flutter_cityshop_store/https/httpRequest_method.dart';

class OnTopBotton extends StatelessWidget {
  final VoidCallback callBack;
  final String title;
  final Widget widget;
  final String productId;

  const OnTopBotton(
      {@required this.callBack,
      @required this.title,
      @required this.widget,
      this.productId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: widget,
        onTap: () {
          callBack?.call();
          // if (title.isNotEmpty) {
          //   _uploadFile();
          // }
        });
  }

  //上传事件名称
  void uploadFile() {
    Future.delayed(const Duration(milliseconds: 500), () {
      this.eventId(title);
    });
  }

  // 外界调用的数据传递入口（App埋点统计）
  void eventId(String eventId) async {
    String token = await LocalStorage.get(Config.TOKEN_KEY);
    var params = {
      "phoneNum": token,
      "event": 'APP_PPV',
      "extraParam2": eventId,
      "extraParam1": (productId == null) ? "1" : productId
    };

    var res =
        await HttpRequestMethod().requestWithMetod(Config.addEventUrl, params);
    print('App埋点上传----$res');
  }
}
