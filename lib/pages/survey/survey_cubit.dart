import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/data_layer/qualtrics_data_sources/qualtrics_local_data_source.dart';
import 'package:libertaspeople/data_layer/qualtrics_data_sources/qualtrics_remote_data_source.dart';
import 'package:libertaspeople/data_layer/user_data_sources/user_local_data_source.dart';
import 'package:libertaspeople/models/question_model.dart';
import 'package:libertaspeople/models/session_info_model.dart';

abstract class SurveyState {}

class UninitialzedSurveyState extends SurveyState {}

class LoadingSurveyState extends SurveyState {}

class FillingOutQuestionSurveyState extends SurveyState {
  final int currentQuestionIndex;
  final SessionInfoModel session;
  final QuestionModel question;
  final int totalQuestionCount;

  FillingOutQuestionSurveyState({
    @required this.currentQuestionIndex,
    @required this.session,
    @required this.question,
    @required this.totalQuestionCount,
  });
}

class ThankYouSurveyState extends SurveyState {}

class FailureSurveyState extends SurveyState {}

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

    emit(FillingOutQuestionSurveyState(
        currentQuestionIndex: 1,
        question: question,
        totalQuestionCount: sessionInfo.questions.length
        // session: sessionInfo,
        ));
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

  answerQuestion() {}

  completeSurvey() {}
}
