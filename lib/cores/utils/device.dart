import 'dart:io';

import 'package:network_info_plus/network_info_plus.dart';

/// {@template device}
/// A class for get some information in device like get device type
/// or get IP address.
/// {@endtemplate}
class Device {
  /// {@macro device}
  const Device();

  /// Get device type Android or iOS.
  String getType() {
    if (Platform.isAndroid) {
      return 'Android';
    } else if (Platform.isIOS) {
      return 'iOS';
    } else {
      return 'Unknown device type';
    }
  }

  /// Get IP address from network device.
  Future<String?> getIPAddress() async => NetworkInfo().getWifiIP();
}
