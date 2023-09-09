import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  Future<bool> getPermission() async {
    bool t = false;
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    late final Map<Permission, PermissionStatus> statuses;
    if (androidInfo.version.sdkInt <= 32) {
      statuses = await [Permission.storage].request();
    } else {
      statuses = await [Permission.storage].request();
    }
    statuses.forEach((permission, status) async {
      if (status.isGranted) {
        t = true;
        if (kDebugMode) {
          print("PermissionStatus => $status");
        }
      } else {
        t = false;
        await Permission.manageExternalStorage.request();
        if (kDebugMode) {
          print("PermissionStatus => $status");
        }
      }
    });
    return t;
  }
}
