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

  final QuestionModel question;

  FillingOutQuestionSurveyState({
    @required this.currentQuestionIndex,
    @required this.question,
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

    // answer initial question 0 and insert question Id
    sessionInfo.questions.forEach((question) => print(question.questionId));
  }

  returnToIncompletedSurveySession({
    @required String surveyId,
    @required String sessionId,
  }) async {
    SessionInfoModel sessionInfo = await qualtricsRemote.getCurrentSession(
        surveyId: surveyId, sessionId: sessionId);
    emit(FillingOutQuestionSurveyState(
        currentQuestionIndex: 1, question: QuestionModel()));
  }

  answerQuestion() {}

  completeSurvey() {}
}
