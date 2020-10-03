import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:libertaspeople/models/api_request_model.dart';

import '../../models/secret_model.dart';
import '../../models/session_info_model.dart';

class QualtricsRemoteDataSource {
  Map<String, String> _getHeader({@required String apiKey}) =>
      {'x-api-token': apiKey, 'Content-Type': 'application/json'};

  String _getBody() => json.encode({'language': 'EN'});

  Future<SessionInfoModel> startSession(
      {@required ApiRequestModel request}) async {
    assert(
        request != null || request.surveyId != null || request.surveyId.isEmpty,
        'Could not start session with null or empty surveyId');

    final SecretModel secrets = await SecretModel.load();

    try {
      final response = await http.post(
          'https://${secrets.dataCenter}.qualtrics.com/API/v3/surveys/${request.surveyId}/sessions',
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

  Future<SessionInfoModel> getCurrentSession(
      {@required ApiRequestModel request}) async {
    assert(request != null,
        'Could not get current session with null request model');
    assert(
        request != null || request.surveyId != null || request.surveyId.isEmpty,
        'Could not get current session with null or empty surveyId');

    assert(request.sessionId != null || request.sessionId.isEmpty,
        'Could not get current session with null or empty sessionId');

    final SecretModel secrets = await SecretModel.load();

    try {
      final response = await http.post(
          'https://${secrets.dataCenter}.qualtrics.com/API/v3/surveys/${request.surveyId}/sessions/${request.sessionId}',
          headers: _getHeader(apiKey: secrets.apiKey));
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
