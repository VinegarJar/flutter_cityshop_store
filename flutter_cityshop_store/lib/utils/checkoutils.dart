
import 'package:intl/intl.dart';

class CheckOutils{
   //校验身份证号码
   static bool checkCard(String idCard){
 

     return isIdCard(idCard);
   }

}

///@author: wangzhanhong
///纯数字正则匹配式
RegExp _pureDigital = RegExp('[0-9]*', multiLine: false);

var _formatter = DateFormat("yyMMdd");

///初步匹配年月日字段
RegExp _dateRegExp = RegExp(
    '^((\d{2}(([02468][048])|([13579][26]))[\-\/\s]?((((0?[13578])|(1[02]))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\-\/\s]?((0?[1-9])|([1-2][0-9])))))|(\d{2}(([02468][1235679])|([13579][01345789]))[\-\/\s]?((((0?[13578])|(1[02]))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\-\/\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))(\s(((0?[0-9])|([1-2][0-3]))\:([0-5]?[0-9])((\s)|(\:([0-5]?[0-9])))))?\$',
    multiLine: false);

const List<int> _power = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];

int _currentYear = int.parse(DateFormat("yyyy").format(DateTime.now()));

Map<String, String> _areaCode;

const List<String> _ValCodeArr = [
  "1",
  "0",
  "x",
  "9",
  "8",
  "7",
  "6",
  "5",
  "4",
  "3",
  "2"
];
const List<String> _Wi = [
  "7",
  "9",
  "10",
  "5",
  "8",
  "4",
  "2",
  "1",
  "6",
  "3",
  "7",
  "9",
  "10",
  "5",
  "8",
  "4",
  "2"
];

const int _YEAR_DELTA = 150;

bool isIdCard(String idCard) {
  if (idCard == null || idCard.isEmpty) {
    print('身份证不能为空');
    return false;
  } else if (!(idCard.length == 15 || idCard.length == 18)) {
    print('身份证必须是15位或者18位');
    return false;
  }
  if (idCard.length == 15 && ((idCard = wrap15To18(idCard)) == null)) {
    return false;
  }
  String ai = "";
  String aiCache = ""; //大写X
  if (idCard.length == 18) {
    ai = idCard.substring(0, 17);
  } else if (idCard.length == 15) {
    ai = idCard.substring(0, 6) + "19" + idCard.substring(6, 15);
  }
  if (!_isDigital(ai)) {
    print('身份证处最后一位必须是纯数字');
    return false;
  }
  String strYear = ai.substring(6, 10); // 年份
  String strMonth = ai.substring(10, 12); // 月份
  String strDay = ai.substring(12, 14); // 月份
  if (_dateRegExp.hasMatch(strYear + "-" + strMonth + "-" + strDay)) {
    print('出生年月日无效');
    return false;
  }
  int yearDelta = int.parse(strYear) - _currentYear;
  //身份证上的年份与当前系统年份差值太大
  //根据需要自定义修改该值
  if (yearDelta.abs() > _YEAR_DELTA) {
    print('年份不对，距离当前年份差量过大');
    return false;
  }
  if (int.parse(strMonth) > 12 || int.parse(strMonth) <= 0) {
    print('月份不对');
    return false;
  }
  if (int.parse(strDay) > 31 || int.parse(strDay) <= 0) {
    print('日期不对');
    return false;
  }
  if (!_getAreaCode().containsKey(ai.substring(0, 2))) {
    print('地区编码错误');
    return false;
  }
  int totalMulAiWi = 0;
  for (int i = 0; i < 17; i++) {
    totalMulAiWi =
        totalMulAiWi + int.parse(ai.substring(i, i + 1)) * int.parse(_Wi[i]);
  }
  int modValue = totalMulAiWi % 11;
  String strVerifyCode = _ValCodeArr[modValue];
  //兼容大写字母X
  if ("x" == strVerifyCode) {
    aiCache = ai + "X";
  }
  ai = ai + strVerifyCode;
  if (idCard.length == 18) {
    if (!(ai == idCard) && !(aiCache == idCard)) {
      return false;
    }
  } else {
    return true;
  }
  return true;
}

///返回'男'或者'女'，请验证身份证号合法之后再使用该函数，
///该函数不会额外去验证输入是否正确
String getGender(String idCard) {
  if (idCard.length == 15 && (idCard = wrap15To18(idCard)) == null) {
    return null;
  }
  String genderStr = idCard.substring(16, 17);
  return (int.parse(genderStr) % 2 != 0) ? '男' : '女';
}

///返回出生年月日，请验证身份证号合法之后再使用该函数，
///该函数不会额外去验证输入是否正确
String getBirthday(String idCard) {
  if (idCard.length == 15 && (idCard = wrap15To18(idCard)) == null) {
    return null;
  }
  return idCard.substring(6, 17);
}

///返回输入身份证的用户周岁，请验证身份证号合法之后再使用该函数，
///该函数不会额外去验证输入是否正确
///计算有误返回-1


Map<String, String> _getAreaCode() {
  if (_areaCode == null) {
    _areaCode = Map();
    _areaCode['11'] = '北京';
    _areaCode['12'] = '天津';
    _areaCode['13'] = '河北';
    _areaCode['14'] = '山西';
    _areaCode['15'] = '内蒙古';
    _areaCode['21'] = '辽宁';
    _areaCode['22'] = '吉林';
    _areaCode['23'] = '黑龙江';
    _areaCode['31'] = '上海';
    _areaCode['32'] = '江苏';
    _areaCode['33'] = '浙江';
    _areaCode['34'] = '安徽';
    _areaCode['35'] = '福建';
    _areaCode['36'] = '江西';
    _areaCode['37'] = '山东';
    _areaCode['41'] = '河南';
    _areaCode['42'] = '湖北';
    _areaCode['43'] = '湖南';
    _areaCode['45'] = '广西';
    _areaCode['44'] = '广东';
    _areaCode['46'] = '海南';
    _areaCode['50'] = '重庆';
    _areaCode['51'] = '四川';
    _areaCode['52'] = '贵州';
    _areaCode['53'] = '云南';
    _areaCode['54'] = '西藏';
    _areaCode['61'] = '陕西';
    _areaCode['62'] = '甘肃';
    _areaCode['63'] = '青海';
    _areaCode['64'] = '宁夏';
    _areaCode['65'] = '新疆';
    _areaCode['71'] = '台湾';
    _areaCode['81'] = '香港';
    _areaCode['82'] = '澳门';
    _areaCode['91'] = '国外';
  }
  return _areaCode;
}

String wrap15To18(String idCard) {
  String idCard17;
  if (idCard == null || idCard.length != 15) {
    return null;
  }
  if (_isDigital(idCard)) {
    String birthday = idCard.substring(6, 12);
    DateTime birthDate;
    try {
      birthDate = _formatter.parse(birthday);
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
    idCard17 =
        "${idCard.substring(0, 6)}${birthDate.year}${idCard17.substring(8)}";
    var bit = _coverCharToInt(idCard.split(''));
    int sum17 = _getPowerSum(bit);
    String checkCode = _getCheckCodeBySum(sum17);
    // 获取不到校验位
    if (null == checkCode) {
      return null;
    }
    // 将前17位与第18位校验码拼接
    idCard17 += checkCode;
  } else {
    return null;
  }
  return idCard17;
}

int _getPowerSum(List<int> bit) {
  int sum = 0;
  if (_power.length != bit.length) {
    return sum;
  }
  for (int i = 0; i < bit.length; i++) {
    for (int j = 0; j < _power.length; j++) {
      if (i == j) {
        sum = sum + bit[i] * _power[j];
      }
    }
  }
  return sum;
}

List<int> _coverCharToInt(List<String> c) {
  var a = [];
  int k = 0;
  c.forEach((str) {
    a[k++] = str as int;
  });
  return a;
}

bool _isDigital(String idCard) {
  return _pureDigital.hasMatch(idCard);
}

String _getCheckCodeBySum(int sum17) {
  String checkCode;
  switch (sum17 % 11) {
    case 10:
      checkCode = "2";
      break;
    case 9:
      checkCode = "3";
      break;
    case 8:
      checkCode = "4";
      break;
    case 7:
      checkCode = "5";
      break;
    case 6:
      checkCode = "6";
      break;
    case 5:
      checkCode = "7";
      break;
    case 4:
      checkCode = "8";
      break;
    case 3:
      checkCode = "9";
      break;
    case 2:
      checkCode = "x";
      break;
    case 1:
      checkCode = "0";
      break;
    case 0:
      checkCode = "1";
      break;
  }
  return checkCode;
}
