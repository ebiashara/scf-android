import 'package:package_info/package_info.dart';

class PackageInfoHelper {
  static Future<String> getPackageName() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }

   static Future<String> getPackageVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return' ${packageInfo.version}';
  }
}
