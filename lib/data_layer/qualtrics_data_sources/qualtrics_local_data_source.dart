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
    File surveyFile = await _surveyListFile;
    List<dynamic> surveyList;
    if ((await surveyFile.exists())) {
      print("survey file exists");
      String fileContents = surveyFile.readAsStringSync();
      surveyList = json.decode(fileContents);
    }
    print("survey list file: $surveyList");
    return surveyList;
  }

  Future<void> storeSurveyList(
    List<dynamic> surveyQualtricsJsonList,
    int surveyFrequencyInMinutes,
  ) async {
    File surveyFile = await _surveyListFile;

    surveyQualtricsJsonList.removeWhere((survey) {
      return !(survey['name'] as String).contains("Survey_");
    });

    surveyQualtricsJsonList.sort((dynamic surveyA, dynamic surveyB) {
      int indexA =
          int.parse((surveyA['name'] as String).replaceAll("Survey_", ""));
      int indexB =
          int.parse((surveyB['name'] as String).replaceAll("Survey_", ""));

      return indexA.compareTo(indexB);
    });

    List<dynamic> surveyList = surveyQualtricsJsonList.map((e) {
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

    List<dynamic> finalSurveyList = surveyList.map((element) {
      element['beginDate'] = initialDate;
      element['finalDate'] = DateTime.parse(element['beginDate'])
          .add(Duration(
              minutes:
                  surveyFrequencyInMinutes)) // for testing purposes, we might want to make the duration 2 days..?
          .toUtc()
          .toString();
      initialDate = element['finalDate'];
      return element;
    }).toList();

    print('survey list inputted into local' + finalSurveyList.toString());

    surveyFile.writeAsStringSync(json.encode(finalSurveyList));
  }

  Future<String> fetchNextSurveyId() async {
    List<dynamic> surveyList = await fetchSurveyList();

    var currentDateTime = DateTime.now();

    String id;
    for (int i = 0; i < surveyList.length; i++) {
      int j = i + 1;
      if (surveyList.elementAt(i)['isComplete'] == true) {
        if (surveyList.elementAt(j)['isComplete'] == false) {
          if (currentDateTime.isAfter(
                  DateTime.parse(surveyList.elementAt(j)['beginDate'])) &&
              currentDateTime.isBefore(
                  DateTime.parse(surveyList.elementAt(j)['finalDate']))) {
            id = surveyList.elementAt(j)['id'];
            break;
          }
        }
      }
    }
    return id ?? null;
  }

  Future<void> markSurveyAsComplete(String surveyId) async {
    print('surveyId: $surveyId');
    List<dynamic> surveyList = await fetchSurveyList();
    File surveyFile = await _surveyListFile;
    List<dynamic> updatedSurveyList = surveyList.map((element) {
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
      int indexA = int.parse(questionA.questionId.replaceAll("QID", ""));
      int indexB = int.parse(questionB.questionId.replaceAll("QID", ""));
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
    SessionInfoModel sessionInfo =
        SessionInfoModel.fromJson(sessionMap['sessionInfoModel']);
    // QuestionModel question = await

    Map<String, dynamic> result = {
      "surveyId": sessionMap['surveyId'],
      "sessionInfoModel": sessionInfo
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
      File sessionFile = await _sessionFile;
      final String jsonString = sessionFile.readAsStringSync();
      Map<String, dynamic> sessionMap = json.decode(jsonString);
      sessionData = StoredSessionDataModel.fromJson(sessionMap);
    } catch (e) {
      print(e);
      // sessionMap = {};
      // We create a Model ourselves with no inputs
      return null;
    }
    // print("session map: $sessionMap");
    return sessionData;
  }

  Future<void> deleteCurrentSessionData() async {
    File sessionFile = await _sessionFile;
    if (await sessionFile.exists()) {
      await sessionFile.delete();
    }
  }
}
