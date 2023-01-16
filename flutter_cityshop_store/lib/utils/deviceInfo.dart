import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  // 静态变量_instance，存储唯一对象
  static DeviceInfo _instance;

  // 工厂模式 单例
  factory DeviceInfo() => _getInstance();

  //获取单利
  static DeviceInfo get instance => _getInstance();

  static DeviceInfo _getInstance() {
    if (_instance == null) {
      _instance = new DeviceInfo._internal();
    }
    return _instance;
  }

  //初始化通用全局单例，第一次使用时初始化
  DeviceInfo._internal() {
    print('初始化通用全局单例--我是DeviceInfo命名构造函数');
  }

  /*
    * @description:  获取设备信息
    * @return {type} 设备信息
    */
  Future<dynamic> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    var dataInfo;
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      dataInfo = iosInfo;
      print('IOS设备--${iosInfo.name}');
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      dataInfo = androidInfo;
      print('Android设备--${androidInfo.device}');
    }
    return dataInfo;
  }

  // 获取设备的唯一标识 uuid
  Future<String> getplatformUid() async {
    var res;
    var data = await DeviceInfo.instance.getDeviceInfo();
    if (Platform.isIOS) {
      res = data.identifierForVendor;
    } else if (Platform.isAndroid) {
      res = data.androidId;
    }
    return res;
  }

  //  获取设备name
  Future<String> getplatformName() async {
    var res;
    var data = await DeviceInfo.instance.getDeviceInfo();
    if (Platform.isIOS) {
      res = data.name;
    } else if (Platform.isAndroid) {
      res = data.device;
    }
    return res;
  }

  // 获取设备的model
  Future<String> getplatformModel() async {
    var res;
    var data = await DeviceInfo.instance.getDeviceInfo();
    if (Platform.isIOS) {
      res = data.utsname.machine;
    } else if (Platform.isAndroid) {
      res = data.brand + ' ' + data.model;
    }
    return res;
  }
}
