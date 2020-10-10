import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class QualtricsLocalDataSource {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Todo: rename _surveyListFile
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

  Future<void> storeSurveyList(List<dynamic> survey_qualtrics_json_list) async {
    File surveyFile = await _surveyListFile;

    survey_qualtrics_json_list.removeWhere((survey) {
      return !(survey['name'] as String).contains("Survey_");
    });

    survey_qualtrics_json_list.sort((dynamic surveyA, dynamic surveyB) {
      int indexA =
          int.parse((surveyA['name'] as String).replaceAll("Survey_", ""));
      int indexB =
          int.parse((surveyB['name'] as String).replaceAll("Survey_", ""));

      return indexA.compareTo(indexB);
    });

    List<dynamic> surveyList = survey_qualtrics_json_list.map((e) {
      return {
        "id": e['id'],
        "name": e['name'],
        "isActive": e['isActive'],
        "isComplete": false,
        "beginDate": "UTC",
        "finalDate": "UTC"
      };
    }).toList();

    var initialDate = DateTime.now().toUtc().toString();

    List<dynamic> finalSurveyList = surveyList.map((element) {
      element['beginDate'] = initialDate;
      element['finalDate'] = DateTime.parse(element['beginDate'])
          .add(Duration(
              days:
                  30)) // for testing purposes, we might want to make the duration 2 days..?
          .toUtc()
          .toString();
      initialDate = element['finalDate'];
      return element;
    }).toList();

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

  Future<void> storeCurrentSessionData(
    String surveyId,
    String sessionId,
  ) async {
    final Map<String, dynamic> currentSessionData = {
      "surveyId": surveyId,
      "sessionId": sessionId
    };
    File sessionFile = await _sessionFile;
    sessionFile.writeAsStringSync(json.encode(currentSessionData));
  }

// May want to convert this to return a MODEL
  Future<Map<String, dynamic>> get getStoredSessionMetaData async {
    Map<String, dynamic> sessionMap;
    try {
      File sessionFile = await _sessionFile;
      final String jsonString = sessionFile.readAsStringSync();
      sessionMap = json.decode(jsonString);
    } on FileSystemException {
      sessionMap = {};
      // We create a Model ourselves with no inputs
    }
    return sessionMap;
  }

  Future<void> deleteCurrentSessionData() async {
    File sessionFile = await _sessionFile;
    if (await sessionFile.exists()) {
      await sessionFile.delete();
    }
  }
}
