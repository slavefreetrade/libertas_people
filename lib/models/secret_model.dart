import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

class SecretModel {
  final String apiKey;
  final String dataCenter;

  SecretModel({this.apiKey = '', this.dataCenter = ''});

  factory SecretModel.fromJson(Map<String, dynamic> jsonMap) {
    return SecretModel(apiKey: jsonMap['api_key'] as String, dataCenter: jsonMap['data_center'] as String);
  }

  ///Should be deleted and replaced with Environment Variable
  static Future<SecretModel> load() async {
    return rootBundle.loadStructuredData<SecretModel>(
      _secretPath,
          (jsonStr) async {
        final secrets =
        SecretModel.fromJson(json.decode(jsonStr) as Map<String, dynamic>);
        return secrets;
      },
    );
  }
}

const String _secretPath = 'assets/secrets.json';