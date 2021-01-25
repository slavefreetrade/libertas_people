import 'dart:io';

import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:device_info/device_info.dart";

class UserLocalDataSource {
  final _storage = const FlutterSecureStorage();
  final _devInfo = DeviceInfoPlugin();

  Future<String> storePreferredLanguage(String preferredLanguage) async {
    try {
      await _storage.write(key: "lan", value: preferredLanguage);
      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> getPreferredLanguage() async {
    try {
      final String result = await _storage.read(key: "lan");
      return result;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> fetchUniqueDeviceID() async {
    if (Platform.isAndroid) {
      final androidInfo = await _devInfo.androidInfo;
      return androidInfo.androidId;
    } else if (Platform.isIOS) {
      final iosInfo = await _devInfo.iosInfo;
      return iosInfo.identifierForVendor;
    } else {
      return null;
      // throw PlatformException(
      //   code: "Unsupported Platfrom",
      //   message: "The plaform of the device is neither ios nor android",
      // );
    }
  }

  Future<String> storeUID(String uniqueDeviceID) async {
    try {
      await _storage.write(key: "uid", value: uniqueDeviceID);
      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> getUID() async {
    try {
      final String result = await _storage.read(key: "uid");
      return result;
    } catch (e) {
      return null;
    }
  }
}
