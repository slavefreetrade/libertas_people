import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/api_request_model.dart';
import '../../models/secret_model.dart';
import '../../models/session_info_model.dart';
import '../../models/survey_reponses_model.dart';

class QualtricsRemoteDataSource {
  Map<String, String> _getHeader({@required String apiKey}) =>
      {'X-API-TOKEN': apiKey, 'Content-Type': 'application/json'};

  String _getBody() => json.encode({'language': 'EN'});

  String _getBodyWithResponses(SurveyResponsesModel response) {
    return json.encode({
      'embeddedData': {'deviceID': response.deviceId},
      'advance': response.advance,
      'responses': response.answers
    });
  }

  // surveyId
  Future<SessionInfoModel> startSession(String surveyId) async {
    assert(surveyId != null || surveyId.isEmpty,
        'Could not start session with null or empty surveyId');

    final SecretModel secrets = await SecretModel.load();
    final uri = Uri.https('${secrets.dataCenter}.qualtrics.com',
        'API/v3/surveys/$surveyId/sessions');

    try {
      final response = await http.post(uri,
          headers: _getHeader(apiKey: secrets.apiKey), body: _getBody());
      if (response.statusCode == 201) {
        return SessionInfoModel.fromJson(
            jsonDecode(response.body)['result'] as Map<String, dynamic>);
      } else {
        throw Exception('@@@ Returned with Error code: ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('@@@ Exception: $e');
    }
  }

  Future<SessionInfoModel> getCurrentSession({
    @required String surveyId,
    @required String sessionId,
  }) async {
    assert(surveyId != null,
        'Could not get current session with null request model');
    assert(surveyId != null || surveyId.isEmpty,
        'Could not get current session with null or empty surveyId');
    assert(sessionId != null || sessionId.isEmpty,
        'Could not get current session with null or empty sessionId');

    final SecretModel secrets = await SecretModel.load();
    final uri = Uri.https('${secrets.dataCenter}.qualtrics.com',
        '/API/v3/surveys/$surveyId/sessions/$sessionId');

    try {
      final response =
          await http.get(uri, headers: _getHeader(apiKey: secrets.apiKey));
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

  Future<void> updateSession(
      {@required ApiRequestModel request,
      @required SurveyResponsesModel surveyResponses}) async {
    assert(request != null,
        'Could not get update session with null request model');
    assert(
        request != null || request.surveyId != null || request.surveyId.isEmpty,
        'Could not get update session with null or empty surveyId');
    assert(request.sessionId != null || request.sessionId.isEmpty,
        'Could not get update session with null or empty sessionId');
    assert(surveyResponses != null,
        'Could not get update session with null response');

    final SecretModel secrets = await SecretModel.load();
    final uri = Uri.https('${secrets.dataCenter}.qualtrics.com',
        '/API/v3/surveys/${request.surveyId}/sessions/${request.sessionId}');

    try {
      final response = await http.post(uri,
          headers: _getHeader(apiKey: secrets.apiKey),
          body: _getBodyWithResponses(surveyResponses));
      if (response.statusCode == 200) {
        //final Map map = jsonDecode(response.body) as Map<String, dynamic>;

        //final bool isDone = map['result']['done'] is String;
        // return isDone ? null : 'done';

        //return map['result'];
      } else {
        throw Exception('@@@ Returned with Error code: ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('@@@ Exception: $e');
    }
  }

  // TODO Data Model
  Future<List<dynamic>> getListOfAvailableSurveys() async {
    final SecretModel secrets = await SecretModel.load();
    final uri =
        Uri.https('${secrets.dataCenter}.qualtrics.com', '/API/v3/surveys');

    try {
      final response =
          await http.get(uri, headers: _getHeader(apiKey: secrets.apiKey));

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['result']["elements"] as List<dynamic>;
        // return SurveyListModel.fromJson(
        //     jsonDecode(response.body)['result'] as Map<String, dynamic>);
      } else {
        throw Exception('@@@ Returned with Error code: ${response.statusCode}');
      }
    } on Exception catch (e) {
      throw Exception('@@@ Exception: $e');
    }
  }
}
