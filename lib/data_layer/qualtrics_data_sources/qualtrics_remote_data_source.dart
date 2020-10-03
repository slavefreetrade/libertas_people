import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/secret_model.dart';
import '../../models/session_info_model.dart';

class QualtricsRemoteDataSource {
  Map<String, String> _getHeader({@required String apiKey}) =>
      {'x-api-token': apiKey, 'Content-Type': 'application/json'};

  String _getBody() => json.encode({'language': 'EN'});

  Future<SessionInfoModel> startSession({@required String surveyId}) async {
    assert(surveyId != null || surveyId.isEmpty,
        'Could not start session with null or empty surveyId');

    final SecretModel secrets = await SecretModel.load();

    try {
      final response = await http.post(
          'https://${secrets.dataCenter}.qualtrics.com/API/v3/surveys/$surveyId/sessions',
          headers: _getHeader(apiKey: secrets.apiKey),
          body: _getBody());
      if (response.statusCode == 200) {
        return SessionInfoModel.fromJson(
            jsonDecode(response.body)['result'] as Map<String, dynamic>);
      } else {
        throw Exception('@@@ Returned with Error code: ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('@@@ Exception: $e');
    }
  }
}
