import 'package:libertaspeople/data_layer/qualtrics_data_sources/qualtrics_local_data_source.dart';
import 'package:libertaspeople/data_layer/qualtrics_data_sources/qualtrics_remote_data_source.dart';
import 'package:libertaspeople/data_layer/user_data_sources/user_local_data_source.dart';
import 'package:libertaspeople/models/api_request_model.dart';
import 'package:libertaspeople/models/question_model.dart';
import 'package:libertaspeople/models/session_info_model.dart';
import 'package:libertaspeople/models/stored_session_data_model.dart';
import 'package:libertaspeople/models/survey_reponses_model.dart';

class Repository {
  QualtricsRemoteDataSource qualtricsRemote = QualtricsRemoteDataSource();
  QualtricsLocalDataSource qualtricsLocal = QualtricsLocalDataSource();
  UserLocalDataSource userLocal = UserLocalDataSource();

  Future<bool> userExists() async {
    final String uid = await userLocal.getUID();
    if (uid == null) {
      return false;
    }
    return true;
  }

  Future<void> createUser() async {
    String userId = await userLocal.fetchUniqueDeviceID();
    await userLocal.storeUID(userId);
  }


  Future<SessionInfoModel> startSession(String surveyId) async {
    SessionInfoModel sessionInfo = await qualtricsRemote.startSession(surveyId);
    await qualtricsLocal.storeEntireSurveySession(surveyId, sessionInfo);
    return sessionInfo;
  }

  Future<SessionInfoModel> returnToPreviousSession() async{
    Map<String, dynamic> sessionInfoMap =
        await qualtricsLocal.fetchSurveySession();
    SessionInfoModel sessionInfo = sessionInfoMap['sessionInfoModel'];
    return sessionInfo;
  }

  Future<QuestionModel> getQuestionForIndex(int index) async {
    Map<String, dynamic> sessionInfoMap =
        await qualtricsLocal.fetchSurveySession();
    SessionInfoModel sessionInfo = sessionInfoMap['sessionInfoModel'];

    QuestionModel question = sessionInfo.questions.firstWhere(
        (question) => question.questionId.contains(index.toString()));

    return question;
  }

  Future<Map<String, dynamic>> getPreviousAnswerByIndex(
      int previousIndex) async {
    Map<String, dynamic> sessionInfoMap =
        await qualtricsLocal.fetchSurveySession();
    SessionInfoModel sessionInfo = sessionInfoMap['sessionInfoModel'];
    String previousAnswerKey = sessionInfo.responses.keys
        .firstWhere((key) => key.contains(previousIndex.toString()), orElse: (){return null;});
    if (previousAnswerKey == null) {
      return null;
    }
    Map<String, dynamic> previousAnswer = {
      previousAnswerKey: sessionInfo.responses[previousAnswerKey]
    };
    return previousAnswer;
  }

  Future<QuestionModel> getNextQuestionForIncompleteSurvey() async {
    Map<String, dynamic> sessionInfoMap =
        await qualtricsLocal.fetchSurveySession();
    SessionInfoModel sessionInfo = sessionInfoMap['sessionInfoModel'];

    Map<String, dynamic> responses = sessionInfo.responses;
    int lastIndexAnswered = 1;
    responses.forEach((key, value) {
      int keyToInteger = int.parse(key.replaceAll("QID", ""));
      if (keyToInteger > lastIndexAnswered) {
        lastIndexAnswered = keyToInteger;
      }
    });
    int nextIndex = lastIndexAnswered + 1;
    QuestionModel question = sessionInfo.questions.firstWhere(
        (question) => question.questionId.contains(nextIndex.toString()));

    return question;
  }

  Future<void> storeAnswer(Map<String, dynamic> answer) async {
    Map<String, dynamic> sessionInfoMap =
        await qualtricsLocal.fetchSurveySession();
    SessionInfoModel sessionInfo = sessionInfoMap['sessionInfoModel'];
    sessionInfo.responses.addAll(answer);
    await qualtricsLocal.storeEntireSurveySession(
        sessionInfoMap['surveyId'], sessionInfo);
  }


  Future<void> fetchAndStoreQualtricsSurveys(int surveyFrequencyInMinutes) async {
    List<dynamic> surveyListFromQualtrics =
        await qualtricsRemote.getListOfAvailableSurveys();
    surveyListFromQualtrics.forEach((survey) => print(survey));
    await qualtricsLocal.storeSurveyList(surveyListFromQualtrics, surveyFrequencyInMinutes);
  }

  Future<StoredSessionDataModel> fetchIncompleteSessionData() async {
    StoredSessionDataModel storedSessionDataModel =
        await qualtricsLocal.getStoredSessionData;
    return storedSessionDataModel;
  }

  // TODO this could return a data model instead of a Map
  Future<Map<String, dynamic>> fetchCurrentSurveyForUser() async {
    List<dynamic> listOfSurveys = await qualtricsLocal.fetchSurveyList();

    final DateTime now = DateTime.now();

    Map<String, dynamic> currentSurveyForUser =
        listOfSurveys.firstWhere((survey) {
      DateTime beginningSurveyDate = DateTime.parse(survey["beginDate"]);
      DateTime endSurveyDate = DateTime.parse(survey["finalDate"]);
      return (now.isAfter(beginningSurveyDate) && now.isBefore(endSurveyDate));
    }, orElse: () {
      return null;
    });

    return currentSurveyForUser;
  }

  Future<void> completeSession() async {
    final String deviceId = await userLocal.fetchUniqueDeviceID();

    Map<String, dynamic> sessionInfoMap =
        await qualtricsLocal.fetchSurveySession();
    SessionInfoModel sessionInfo = sessionInfoMap['sessionInfoModel'];

    await qualtricsRemote.updateSession(
      request: ApiRequestModel(
        surveyId: sessionInfoMap['surveyId'],
        sessionId: sessionInfo.sessionId,
      ),
      surveyResponses: SurveyResponsesModel(
        answers: sessionInfo.responses,
        advance: true,
        deviceId: deviceId,
      ),
    );
    await qualtricsLocal.markSurveyAsComplete(sessionInfoMap['surveyId']);
    await qualtricsLocal.deleteCurrentSessionData();

    //todo if survey's beginDate is null or title is Survey_1 update all surveys dates
  }
}
