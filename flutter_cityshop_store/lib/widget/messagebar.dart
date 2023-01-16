import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee_flutter/marquee_flutter.dart';

class MessageBar extends StatelessWidget {
  MessageBar({Key key}) : super(key: key);

  final List listData = [
  
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(88),
        width: ScreenUtil().setWidth(700),
        child:   MarqueeWidget(
            text: "平台承诺不额外向用户收取费用，年利率不超过7%~36%，到账时间5分钟起，额度和反馈时间以实际审批结果为准；（到账时间：提交接口申请到资金到账时间）贷款有风险，借贷需谨慎；请根据个人能力和你贷款，理性消费，避免逾期；资金来源：国美小额贷款有限公司、重庆黑卡小额贷款有限公司等金融服务将根据您的个人情况有适合的正规金融机构提供。",
            textStyle: new TextStyle(fontSize: 16.0),
            scrollAxis: Axis.horizontal,
          )
    
      );
  
  }
}
