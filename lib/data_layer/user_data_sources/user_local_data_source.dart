import 'dart:io';

import 'package:flutter/services.dart';
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:device_info/device_info.dart";

class UserLocalDataSource {
  final storage = FlutterSecureStorage();
  final devInfo = DeviceInfoPlugin();
  storePreferredLanguage(String preferredLanguage) async {
    try {
      await storage.write(key: "lan", value: preferredLanguage);
      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  getPreferredLanguage() async {
    try {
      String result = await storage.read(key: "lan");
      print("$result");
      return result;
    } catch (e) {
      return e.toString();
    }
  }

  fetchUniqueDeviceID() async {
    if (Platform.isAndroid) {
      var androidInfo = await devInfo.androidInfo;
      print("${androidInfo.id}");
      return "${androidInfo.androidId}";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosinfo = await devInfo.iosInfo;
      print("${iosinfo.identifierForVendor}");
      return "${iosinfo.identifierForVendor}";
    } else {
      throw PlatformException(
        code: "Unsupported Platfrom",
        message: "The plaform of the device is neither ios nor android",
      );
    }
  }

  storeUID(String uniqueDeviceID) async {
    try {
      await storage.write(key: "uid", value: uniqueDeviceID);
      print("success");
      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  getUID() async {
    try {
      String result = await storage.read(key: "uid");
      print("$result");
      return result;
    } catch (e) {
      return e.toString();
    }
  }
}
