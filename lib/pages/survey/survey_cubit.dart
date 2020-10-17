import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:libertaspeople/data_layer/qualtrics_data_sources/new_qualtrics_local_data_source.dart';
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
  final QuestionModel question;
  final int totalQuestionCount;
  final Map previousAnswer;

  FillingOutQuestionSurveyState({
    @required this.currentQuestionIndex,
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

  NewQualtricsLocalDataSource newQualtricsLocalDataSource =
      NewQualtricsLocalDataSource();

  startSurvey(String surveyId) async {
    if(state is LoadingSurveyState) return;
    emit(LoadingSurveyState());
    SessionInfoModel sessionInfo = await qualtricsRemote.startSession(surveyId);

    print("checkout session info questions");

    await newQualtricsLocalDataSource.storeEntireSurveySession(
        surveyId, sessionInfo);

    QuestionModel question = sessionInfo.questions
        .firstWhere((question) => question.questionId.contains("1"));

    emit(
      FillingOutQuestionSurveyState(
          currentQuestionIndex: 1,
          question: question,
          totalQuestionCount: sessionInfo.questions.length),
    );
  }

  returnToIncompletedSurveySession({
    @required String surveyId,
    @required String sessionId,
  }) async {
    emit(LoadingSurveyState());

    Map<String, dynamic> sessionInfoMap =
        await newQualtricsLocalDataSource.fetchSurveySession();

    SessionInfoModel sessionInfo = sessionInfoMap['sessionInfoModel'];

    // Repo.findNextQuestionForIncompleteSurvey
    Map<String, dynamic> responses = sessionInfo.responses;
    print("responses: $responses");
    int lastIndexAnswered = 1;
    responses.forEach((key, value) {
      int keyToInteger = int.parse(key.replaceAll("QID", ""));
      print(keyToInteger);
      if (keyToInteger > lastIndexAnswered) {
        lastIndexAnswered = keyToInteger;
      }
    });
    int nextIndex = lastIndexAnswered + 1;
    QuestionModel question = sessionInfo.questions.firstWhere((question) =>
        question.questionId.contains(nextIndex.toString())); // valid

    emit(
      FillingOutQuestionSurveyState(
        currentQuestionIndex: nextIndex,
        question: question,
        totalQuestionCount: sessionInfo.questions.length,
      ),
    );
  }

  nextQuestion(Map answer) async {
    if (state is FillingOutQuestionSurveyState) {
      int nextIndex =
          (state as FillingOutQuestionSurveyState).currentQuestionIndex + 1;
      print('answer $answer');

      emit(LoadingSurveyState());

      // Repo.StoreAnswer()
      Map<String, dynamic> sessionInfoMap =
          await newQualtricsLocalDataSource.fetchSurveySession();
      SessionInfoModel sessionInfo = sessionInfoMap['sessionInfoModel'];
      sessionInfo.responses.addAll(answer);
      await newQualtricsLocalDataSource.storeEntireSurveySession(
          sessionInfoMap['surveyId'], sessionInfo);

      emit(
        FillingOutQuestionSurveyState(
            currentQuestionIndex: nextIndex,
            question: sessionInfo.questions[nextIndex - 1],
            totalQuestionCount: sessionInfo.questions.length),
      );
    }
  }

  previousQuestion() async {
    if (state is FillingOutQuestionSurveyState) {
      int previousIndex =
          (state as FillingOutQuestionSurveyState).currentQuestionIndex - 1;
      print('previous index : $previousIndex');

      emit(LoadingSurveyState());

      // Prolly split into two calls?
      // Repo.findPreviousQuesitonAndAnswerByIndex()
      Map<String, dynamic> sessionInfoMap =
          await newQualtricsLocalDataSource.fetchSurveySession();
      SessionInfoModel sessionInfo = sessionInfoMap['sessionInfoModel'];
      String previousAnswerKey = sessionInfo.responses.keys
          .firstWhere((key) => key.contains(previousIndex.toString()));
      Map<String, dynamic> previousAnswer = {
        previousAnswerKey: sessionInfo.responses[previousAnswerKey]
      };
      print("previous andswer: $previousAnswer");

      // FIND QUESTION BY INDEX
      QuestionModel previousQuestion = sessionInfo.questions.firstWhere(
          (question) => question.questionId.contains(previousIndex.toString()));

      emit(
        FillingOutQuestionSurveyState(
          currentQuestionIndex: previousIndex,
          question: previousQuestion,
          totalQuestionCount: sessionInfo.questions.length,
          previousAnswer: previousAnswer,
        ),
      );
    }
  }

  completeSurvey(Map answer) async {
    if (state is FillingOutQuestionSurveyState) {
      emit(LoadingSurveyState());

      // Repo.StoreAnswer
      Map<String, dynamic> sessionInfoMap =
          await newQualtricsLocalDataSource.fetchSurveySession();
      SessionInfoModel sessionInfo = sessionInfoMap['sessionInfoModel'];
      sessionInfo.responses.addAll(answer);
      await newQualtricsLocalDataSource.storeEntireSurveySession(
          sessionInfoMap['surveyId'], sessionInfo);

      // try to send session to API
      try {
        // REPO.completeSession
        final String deviceId = await userLocal.fetchUniqueDeviceID();

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

        await qualtricsLocal.deleteCurrentSessionData();

        await qualtricsLocal.markSurveyAsComplete(sessionInfoMap['surveyId']);

        //todo if survey title is Survey_1, update all surveys dates

        emit(ThankYouSurveyState());
      } catch (e) {
        print("exception submitting survey: $e");
        print(e.toString());
        emit(FailureSurveyState(
            "we are unable to submit your survey at this time, we will notify you when it is submitted"));
      }
    }
  }
}
