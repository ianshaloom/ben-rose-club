// lib/services/device_service.dart
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DeviceService {
  static final _deviceInfo = DeviceInfoPlugin();
  static const _uuid = Uuid();

  /// Returns a **stable** identifier that survives app restarts
  /// but changes after reinstall (good compromise for privacy).
  static Future<String> get deviceId async {
    // Persist the generated id locally (e.g. using shared_preferences).
    // If found, reuse; otherwise create one:
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('device_id');
    if (id != null) return id;

    if (Platform.isAndroid) {
      final info = await _deviceInfo.androidInfo;
      id = _uuid.v5(Namespace.url.name, '${info.id}${info.serialNumber}');
    } else if (Platform.isIOS) {
      final info = await _deviceInfo.iosInfo;
      id = _uuid.v5(
        Namespace.url.name,
        '${info.identifierForVendor}${info.utsname.machine}',
      );
    } else {
      id = _uuid.v4();
    }
    await prefs.setString('device_id', id);
    return id;
  }

  static Future<Map<String, dynamic>> get deviceSnapshot async {
    if (Platform.isAndroid) {
      final i = await _deviceInfo.androidInfo;
      return {'model': i.model, 'brand': i.brand, 'version': i.version.release};
    }
    if (Platform.isIOS) {
      final i = await _deviceInfo.iosInfo;
      return {
        'model': i.utsname.machine,
        'systemName': i.systemName,
        'systemVersion': i.systemVersion,
      };
    }
    return {};
  }
}
