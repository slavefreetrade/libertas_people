import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/data_layer/qualtrics_data_sources/qualtrics_local_data_source.dart';
import 'package:libertaspeople/data_layer/qualtrics_data_sources/qualtrics_remote_data_source.dart';
import 'package:libertaspeople/data_layer/user_data_sources/user_local_data_source.dart';
import 'package:libertaspeople/models/api_request_model.dart';
import 'package:libertaspeople/models/question_model.dart';
import 'package:libertaspeople/models/session_info_model.dart';
import 'package:libertaspeople/models/survey_reponses_model.dart';

abstract class SurveyState {}

class UninitialzedSurveyState extends SurveyState {}

class LoadingSurveyState extends SurveyState {}

class FillingOutQuestionSurveyState extends SurveyState {
  final int currentQuestionIndex;
  final SessionInfoModel session;
  final QuestionModel question;
  final int totalQuestionCount;
  final Map previousAnswer; // If there is an answer already saved for this question

  FillingOutQuestionSurveyState({
    @required this.currentQuestionIndex,
    @required this.session,
    @required this.question,
    @required this.totalQuestionCount,
    this.previousAnswer,
  });
}

class ThankYouSurveyState extends SurveyState {}

class FailureSurveyState extends SurveyState {
  final String message;

  FailureSurveyState(this.message);
}

class SurveyCubit extends Cubit<SurveyState> {
  SurveyCubit() : super(UninitialzedSurveyState());

  QualtricsRemoteDataSource qualtricsRemote = QualtricsRemoteDataSource();
  QualtricsLocalDataSource qualtricsLocal = QualtricsLocalDataSource();
  UserLocalDataSource userLocal = UserLocalDataSource();

  // could store survey ID and session ID globally because they wont change

  startSurvey(String surveyId) async {
    SessionInfoModel sessionInfo = await qualtricsRemote.startSession(surveyId);
    await qualtricsLocal.storeCurrentSessionData(
        surveyId, sessionInfo.sessionId);

    print("survey ID : $surveyId");

    // answer initial question 0 and insert question Id
    sessionInfo.questions.forEach((question) {
      print("question");
      print(question.questionId);
      print(question.choices);
    });

    QuestionModel question = sessionInfo.questions
        .firstWhere((question) => question.questionId.contains("1"));

    emit(
      FillingOutQuestionSurveyState(
          currentQuestionIndex: 1,
          question: question,
          totalQuestionCount: sessionInfo.questions.length
          // session: sessionInfo,
          ),
    );
  }


  returnToIncompletedSurveySession({
    @required String surveyId,
    @required String sessionId,
  }) async {
    SessionInfoModel sessionInfo = await qualtricsRemote.getCurrentSession(
        surveyId: surveyId, sessionId: sessionId);
    sessionInfo.questions.forEach((question) {
      print("question");
      print(question.questionId);
      print(question.display);
      print(question.choices);
    });

    // TODO crunch logic to find out which was the last quesiton answered

    // got to go through answers and figure out which havent been answered
    QuestionModel question = sessionInfo.questions
        .firstWhere((question) => question.questionId.contains("1")); // valid

    emit(FillingOutQuestionSurveyState(
        currentQuestionIndex: 1,
        question: question,
        totalQuestionCount: sessionInfo.questions.length

        // session: sessionInfo,
        ));
  }

  // determine if an answer is null, TextAnswer or MCAnswer
  // if null, just go to next question
  nextQuestion(Map answer) async {

    ///REPO Function
    // check to see if answer for next question has been submitted
    // need to answer question if no answer present in widget (handle in widget)
    Map<String, dynamic> info = await qualtricsLocal.getStoredSessionMetaData;
    String deviceId = await userLocal.fetchUniqueDeviceID();

    // submit answer to session
    final Map updatedSessionInfo = await qualtricsRemote.updateSession(
        request: ApiRequestModel(
            sessionId: info['sessionId'], surveyId: info['surveyId']),
        surveyResponses: SurveyResponsesModel(
            answers: answer, advance: false, deviceId: deviceId));



    final int currentIndex =
        (state as FillingOutQuestionSurveyState).currentQuestionIndex + 1;

    // emit Filling Out Questions
    emit(
      FillingOutQuestionSurveyState(
          currentQuestionIndex: currentIndex,
          session: null,
          question: null,
          totalQuestionCount: null),
    );
  }

  previousQuestion() {
    // find question by previous index

    // get answer for that question,

    // feed question and answer to the question page

    // emit Filling Out Questions
  }

  completeSurvey() {}
}
