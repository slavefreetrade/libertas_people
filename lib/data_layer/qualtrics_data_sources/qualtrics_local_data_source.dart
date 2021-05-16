import 'dart:convert';
import 'dart:io';

import 'package:libertaspeople/models/question_model.dart';
import 'package:libertaspeople/models/session_info_model.dart';
import 'package:libertaspeople/models/stored_session_data_model.dart';
import 'package:path_provider/path_provider.dart';

class QualtricsLocalDataSource {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _surveyListFile async {
    final path = await _localPath;
    return File('$path/survey_list.txt');
  }

  Future<File> get _sessionFile async {
    final path = await _localPath;
    return File('$path/current_session.txt');
  }

  Future<List<dynamic>> fetchSurveyList() async {
    final File surveyFile = await _surveyListFile;
    List<dynamic> surveyList;
    if (await surveyFile.exists()) {
      final String fileContents = surveyFile.readAsStringSync();
      surveyList = json.decode(fileContents) as List<dynamic>;
    }
    return surveyList;
  }

  Future<void> storeSurveyList(
    List<dynamic> surveyQualtricsJsonList,
    int surveyFrequencyInMinutes,
  ) async {
    final File surveyFile = await _surveyListFile;

    surveyQualtricsJsonList.removeWhere((survey) {
      return !(survey['name'] as String).contains("WA_Continuous_");
    });

    surveyQualtricsJsonList.sort((dynamic surveyA, dynamic surveyB) {
      final int indexA =
          int.parse((surveyA['name'] as String).replaceAll("WA_Continuous_", ""));
      final int indexB =
          int.parse((surveyB['name'] as String).replaceAll("WA_Continuous_", ""));

      return indexA.compareTo(indexB);
    });

    final List<dynamic> surveyList = surveyQualtricsJsonList.map((e) {
      return {
        "id": e['id'],
        "name": e['name'],
        "isActive": e['isActive'],
        "isComplete": false,
        "beginDate": "UTC",
        "finalDate": "UTC"
      };
    }).toList();

    // TODO move the updating of dates to complete to after submitting first survey
    var initialDate = DateTime.now().toUtc().toString();

    final List<dynamic> finalSurveyList = surveyList.map((element) {
      element['beginDate'] = initialDate;
      element['finalDate'] = DateTime.parse(element['beginDate'] as String)
          .add(Duration(
              minutes:
                  surveyFrequencyInMinutes)) // for testing purposes, we might want to make the duration 2 days..?
          .toUtc()
          .toString();
      initialDate = element['finalDate'] as String;
      return element;
    }).toList();

    surveyFile.writeAsStringSync(json.encode(finalSurveyList));
  }

  Future<String> fetchNextSurveyId() async {
    final List<dynamic> surveyList = await fetchSurveyList();

    final currentDateTime = DateTime.now();

    String id;
    for (int i = 0; i < surveyList.length; i++) {
      final int j = i + 1;
      if (surveyList.elementAt(i)['isComplete'] == true) {
        if (surveyList.elementAt(j)['isComplete'] == false) {
          if (currentDateTime.isAfter(DateTime.parse(
                  surveyList.elementAt(j)['beginDate'] as String)) &&
              currentDateTime.isBefore(DateTime.parse(
                  surveyList.elementAt(j)['finalDate'] as String))) {
            id = surveyList.elementAt(j)['id'] as String;
            break;
          }
        }
      }
    }
    return id;
  }

  Future<void> markSurveyAsComplete(String surveyId) async {
    final List<dynamic> surveyList = await fetchSurveyList();
    final File surveyFile = await _surveyListFile;
    final List<dynamic> updatedSurveyList = surveyList.map((element) {
      if (element['id'] == surveyId) {
        element['isComplete'] = true;
      }
      return element;
    }).toList();
    final String jsonString = json.encode(updatedSurveyList);
    surveyFile.writeAsStringSync(jsonString, mode: FileMode.writeOnly);
  }

  Future storeEntireSurveySession(
      String surveyId, SessionInfoModel sessionInfo) async {
    // just in case the questions come in UNORDERED, sort them
    sessionInfo.questions
        .sort((QuestionModel questionA, QuestionModel questionB) {
      final int indexA = int.parse(questionA.questionId.replaceAll("QID", ""));
      final int indexB = int.parse(questionB.questionId.replaceAll("QID", ""));
      return indexA.compareTo(indexB);
    });

    final Map<String, dynamic> currentSessionData = {
      "surveyId": surveyId,
      "sessionInfoModel": sessionInfo.toJson()
    };
    final File sessionFile = await _sessionFile;
    sessionFile.writeAsStringSync(json.encode(currentSessionData));
  }

  /// Response may be null
  Future<Map<String, dynamic>> fetchSurveySession() async {
    final sessionFile = await _sessionFile;

    final jsonString = sessionFile.readAsStringSync();
    final sessionInfoMap = json.decode(jsonString) as Map<String, dynamic>;
    final SessionInfoModel sessionInfo = SessionInfoModel.fromJson(
        sessionInfoMap['sessionInfoModel'] as Map<String, dynamic>);
    // QuestionModel question = await

    final Map<String, dynamic> result = {
      "surveyId": sessionInfoMap['surveyId'],
      "sessionInfoModel": sessionInfo.toJson(),
    };
    return result;
  }

  // Future<void> storeCurrentSessionData(
  //   String surveyId,
  //   String sessionId,
  // ) async {
  //   final Map<String, dynamic> currentSessionData = {
  //     "surveyId": surveyId,
  //     "sessionId": sessionId
  //   };
  //   File sessionFile = await _sessionFile;
  //   sessionFile.writeAsStringSync(json.encode(currentSessionData));
  // }

  Future<StoredSessionDataModel> get getStoredSessionData async {
    // Map<String, dynamic> sessionMap;
    StoredSessionDataModel sessionData;
    try {
      final sessionFile = await _sessionFile;
      final jsonString = sessionFile.readAsStringSync();
      final sessionMap = json.decode(jsonString) as Map<String, dynamic>;
      sessionData = StoredSessionDataModel.fromJson(sessionMap);
    } catch (e) {
      // sessionMap = {};
      // We create a Model ourselves with no inputs
      return null;
    }
    // print("session map: $sessionMap");
    return sessionData;
  }

  Future<void> deleteCurrentSessionData() async {
    final File sessionFile = await _sessionFile;
    if (await sessionFile.exists()) {
      await sessionFile.delete();
    }
  }
}
