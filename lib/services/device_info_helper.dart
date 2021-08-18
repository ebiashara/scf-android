import 'dart:io';
import 'dart:ui';

import 'package:device_info/device_info.dart';

class DeviceInfoHelper {
  static final _deviceInfoPlugin = DeviceInfoPlugin();
  static Future<String> getOS() async=> Platform.operatingSystem;
  static Future<String> getScreenResolution() async => '${window.physicalSize.width } X ${window.physicalSize.height }';


  static Future<String> getDeviceInfo() async {
    if (Platform.isAndroid) {
      final deviceInfo = await _deviceInfoPlugin.androidInfo;
      return '${deviceInfo.manufacturer} -- ${deviceInfo.model}';
    } else if (Platform.isIOS){
       final deviceInfo = await _deviceInfoPlugin.iosInfo;
      return '${deviceInfo.name} -- ${deviceInfo.model}';
    }
    else {
      throw UnimplementedError();
    }
  }

  static Future<String> getOsVersion() async {
    if (Platform.isAndroid) {
      final deviceInfo = await _deviceInfoPlugin.androidInfo;
      return deviceInfo.version.sdkInt.toString();
    } else if (Platform.isIOS){
       final deviceInfo = await _deviceInfoPlugin.iosInfo;
      return deviceInfo.systemVersion;
    }
    else {
      throw UnimplementedError();
    }
  }
}
