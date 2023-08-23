import 'dart:io';

import 'package:network_info_plus/network_info_plus.dart';

class Device {
  const Device._();

  /// Get device type Android or iOS.
  static String getType() => Platform.isAndroid ? 'Android' : 'iOS';

  static Future<String?> getIPAddress() async => NetworkInfo().getWifiIP();
}
