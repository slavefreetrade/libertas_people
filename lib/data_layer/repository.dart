import 'package:libertaspeople/data_layer/qualtrics_data_sources/qualtrics_local_data_source.dart';
import 'package:libertaspeople/data_layer/qualtrics_data_sources/qualtrics_remote_data_source.dart';
import 'package:libertaspeople/data_layer/user_data_sources/user_local_data_source.dart';

class Repository {
  QualtricsRemoteDataSource qualtricsRemote = QualtricsRemoteDataSource();
  QualtricsLocalDataSource qualtricsLocal = QualtricsLocalDataSource();
  UserLocalDataSource userLocal = UserLocalDataSource();

  Future<void> createUser() async {
    String userId = await userLocal.fetchUniqueDeviceID();
    await userLocal.storeUID(userId);
  }

  Future<void> fetchAndStoreQualtricsSurveys() async {
    List<dynamic> surveyListFromQualtrics =
        await qualtricsRemote.getListOfAvailableSurveys();
    surveyListFromQualtrics.forEach((survey) => print(survey));
    await qualtricsLocal.storeSurveyList(surveyListFromQualtrics);
  }

  Future<Map<String, dynamic>> fetchIncompleteSessionMetaData() async {
    Map<String, dynamic> storedSessionMetaData =
        await qualtricsLocal.getStoredSessionMetaData;
    return storedSessionMetaData;
  }

  Future<Map<String, dynamic>> fetchCurrentSurveyForUser() async {
    List<dynamic> listOfSurveys = await qualtricsLocal.fetchSurveyList();

    final DateTime now = DateTime.now();

    Map<String, dynamic> currentSurveyForUser =
        listOfSurveys.firstWhere((survey) {
      DateTime beginningSurveyDate = DateTime.parse(survey["beginDate"]);
      DateTime endSurveyDate = DateTime.parse(survey["finalDate"]);
      return (now.isAfter(beginningSurveyDate) && now.isBefore(endSurveyDate));
    });

    return currentSurveyForUser;
  }

  completeSurvey() {
    // once everything sent to qualtrics returns good
    // delete unfinishedSessionMetaData file
  }
}
