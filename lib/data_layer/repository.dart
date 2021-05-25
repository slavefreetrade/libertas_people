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
    final String userId = await userLocal.fetchUniqueDeviceID();
    await userLocal.storeUID(userId);
  }

  Future<SessionInfoModel> startSession(String surveyId) async {
    final SessionInfoModel sessionInfo =
        await qualtricsRemote.startSession(surveyId);
    await qualtricsLocal.storeEntireSurveySession(surveyId, sessionInfo);
    return sessionInfo;
  }

  Future<SessionInfoModel> returnToPreviousSession() async {
    final Map<String, dynamic> sessionInfoMap =
        await qualtricsLocal.fetchSurveySession();
    final SessionInfoModel sessionInfo = SessionInfoModel.fromJson(
        sessionInfoMap['sessionInfoModel'] as Map<String, dynamic>);
    return sessionInfo;
  }

  Future<QuestionModel> getQuestionForIndex(int index) async {
    final Map<String, dynamic> sessionInfoMap =
        await qualtricsLocal.fetchSurveySession();
    final SessionInfoModel sessionInfo = SessionInfoModel.fromJson(
        sessionInfoMap['sessionInfoModel'] as Map<String, dynamic>);

    //final questionIdList = sessionInfo.questions
    //         .map((e) => int.parse(e.questionId.replaceAll('QID', '')))
    //         .toList();
    //     final questionNumber = questionIdList.where((e) => index >= e).first;
    //     final questionIndex = questionIdList.indexOf(questionNumber);
    //     final QuestionModel question = sessionInfo.questions[questionIndex];

    final QuestionModel question = sessionInfo.questions.firstWhere(
        (question) =>
            int.parse(question.questionId.replaceAll('QID', '')) >= index);

    return question;
  }

  Future<Map<String, dynamic>> getPreviousAnswerByIndex(
      int previousIndex) async {
    final Map<String, dynamic> sessionInfoMap =
        await qualtricsLocal.fetchSurveySession();
    final SessionInfoModel sessionInfo = SessionInfoModel.fromJson(
        sessionInfoMap['sessionInfoModel'] as Map<String, dynamic>);
    final String previousAnswerKey = sessionInfo.responses.keys.firstWhere(
        (key) => key.contains(previousIndex.toString()), orElse: () {
      return null;
    });
    if (previousAnswerKey == null) {
      return null;
    }
    final Map<String, dynamic> previousAnswer = {
      previousAnswerKey: sessionInfo.responses[previousAnswerKey]
    };
    return previousAnswer;
  }

  Future<QuestionModel> getNextQuestionForIncompleteSurvey() async {
    final Map<String, dynamic> sessionInfoMap =
        await qualtricsLocal.fetchSurveySession();
    final SessionInfoModel sessionInfo = SessionInfoModel.fromJson(
        sessionInfoMap['sessionInfoModel'] as Map<String, dynamic>);

    final Map<String, dynamic> responses = sessionInfo.responses;
    int lastIndexAnswered = 0;
    responses.forEach((key, value) {
      final int keyToInteger = int.parse(key.replaceAll("QID", ""));
      if (keyToInteger > lastIndexAnswered) {
        lastIndexAnswered = keyToInteger;
      }
    });
    final int nextIndex = lastIndexAnswered + 1;

    // TODO handle FIRST WHERE orElse case
    QuestionModel question = sessionInfo.questions.firstWhere(
        (question) => question.questionId.contains(nextIndex.toString()),
        orElse: () => null);

    return question ??= sessionInfo.questions.firstWhere(
        (question) => question.questionId.contains((nextIndex - 1).toString()));
  }

  Future<void> storeAnswer(Map<String, dynamic> answer) async {
    final Map<String, dynamic> sessionInfoMap =
        await qualtricsLocal.fetchSurveySession();
    final SessionInfoModel sessionInfo = SessionInfoModel.fromJson(
        sessionInfoMap['sessionInfoModel'] as Map<String, dynamic>);
    sessionInfo.responses.addAll(answer);
    await qualtricsLocal.storeEntireSurveySession(
        sessionInfoMap['surveyId'] as String, sessionInfo);
  }

  Future<void> fetchAndStoreQualtricsSurveys(
      int surveyFrequencyInMinutes) async {
    final List<dynamic> surveyListFromQualtrics =
        await qualtricsRemote.getListOfAvailableSurveys();
    await qualtricsLocal.storeSurveyList(
        surveyListFromQualtrics, surveyFrequencyInMinutes);
  }

  Future<StoredSessionDataModel> fetchIncompleteSessionData() async {
    final StoredSessionDataModel storedSessionDataModel =
        await qualtricsLocal.getStoredSessionData;
    return storedSessionDataModel;
  }

  // TODO this could return a data model instead of a Map
  Future<Map<String, dynamic>> fetchCurrentSurveyForUser() async {
    final List<dynamic> listOfSurveys = await qualtricsLocal.fetchSurveyList();

    final DateTime now = DateTime.now();

    final Map<String, dynamic> currentSurveyForUser =
        listOfSurveys?.firstWhere((survey) {
      final DateTime beginningSurveyDate =
          DateTime.parse(survey["beginDate"] as String);
      final DateTime endSurveyDate =
          DateTime.parse(survey["finalDate"] as String);
      return now.isAfter(beginningSurveyDate) && now.isBefore(endSurveyDate);
    }, orElse: () {
      return null;
    }) as Map<String, dynamic>;

    return currentSurveyForUser;
  }

  Future<void> completeSession() async {
    final String deviceId = await userLocal.fetchUniqueDeviceID();

    final Map<String, dynamic> sessionInfoMap =
        await qualtricsLocal.fetchSurveySession();
    final SessionInfoModel sessionInfo = SessionInfoModel.fromJson(
        sessionInfoMap['sessionInfoModel'] as Map<String, dynamic>);

    await qualtricsRemote.updateSession(
      request: ApiRequestModel(
        surveyId: sessionInfoMap['surveyId'] as String,
        sessionId: sessionInfo.sessionId,
      ),
      surveyResponses: SurveyResponsesModel(
        answers: sessionInfo.responses,
        advance: true,
        deviceId: deviceId,
      ),
    );
    await qualtricsLocal
        .markSurveyAsComplete(sessionInfoMap['surveyId'] as String);
    await qualtricsLocal.deleteCurrentSessionData();

    //todo if survey's beginDate is null or title is Survey_1 update all surveys dates
  }
}
