import 'dart:convert';
import 'dart:io';

import 'package:libertaspeople/models/question_model.dart';
import 'package:libertaspeople/models/session_info_model.dart';
import 'package:path_provider/path_provider.dart';

class NewQualtricsLocalDataSource {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _sessionFile async {
    final path = await _localPath;
    return File('$path/current_session.txt');
  }

  Future storeEntireSurveySession(
      String surveyId, SessionInfoModel sessionInfo) async {

    // just in case the questions come in UNORDERED, sort them
    sessionInfo.questions
        .sort((QuestionModel questionA, QuestionModel questionB) {
          int indexA = int.parse(questionA.questionId.replaceAll("QID",""));
          int indexB = int.parse(questionB.questionId.replaceAll("QID",""));
          return indexA.compareTo(indexB);
    });

    final Map<String, dynamic> currentSessionData = {
      "surveyId": surveyId,
      "sessionInfoModel": sessionInfo.toJson()
    };
    File sessionFile = await _sessionFile;
    sessionFile.writeAsStringSync(json.encode(currentSessionData));
  }

  /// Response may be null
  Future<Map<String, dynamic>> fetchSurveySession() async {
    File sessionFile = await _sessionFile;

    final String jsonString = sessionFile.readAsStringSync();
    Map sessionMap = json.decode(jsonString);
    SessionInfoModel sessionInfo = SessionInfoModel.fromJson(sessionMap['sessionInfoModel']);
    // QuestionModel question = await

    Map<String, dynamic> result = {"surveyId" : sessionMap['surveyId'], "sessionInfoModel": sessionInfo};
    return result;
  }
}
