import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:libertaspeople/data_layer/qualtrics_data_sources/new_qualtrics_local_data_source.dart';
import 'package:libertaspeople/data_layer/qualtrics_data_sources/qualtrics_local_data_source.dart';
import 'package:libertaspeople/data_layer/qualtrics_data_sources/qualtrics_remote_data_source.dart';
import 'package:libertaspeople/data_layer/repository.dart';
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

  final Repository repository = Repository();

  startSurvey(String surveyId) async {
    if (state is LoadingSurveyState) return;
    emit(LoadingSurveyState());

    // REPOSITORY.StartSession
    SessionInfoModel sessionInfo = await qualtricsRemote.startSession(surveyId);
    await qualtricsLocal.storeEntireSurveySession(surveyId, sessionInfo);
    SessionInfoModel session = await repository.startSession(surveyId);

    // REPOSITORY.getQuestionForIndex(int) -> QuestionModel
    // QuestionModel question = sessionInfo.questions
    //     .firstWhere((question) => question.questionId.contains("1"));

    QuestionModel question = await repository.getQuestionForIndex(1);

    emit(
      FillingOutQuestionSurveyState(
          currentQuestionIndex: question.currentIndex,
          question: question,
          totalQuestionCount: session.questions.length),
    );
  }

  returnToIncompleteSurveySession({
    @required String surveyId,
    @required String sessionId,
  }) async {
    if (state is LoadingSurveyState) return;
    emit(LoadingSurveyState());

    // ALREADY EXISTS??? / COULD KEEP IN REPO LAYER
    // REPOSITORY.FetchCurrentSession
    // TODO DATA MODEL
    Map<String, dynamic> sessionInfoMap =
        await qualtricsLocal.fetchSurveySession();
    SessionInfoModel sessionInfo = sessionInfoMap['sessionInfoModel'];

    // REPOSITORY.findNextQuestionForIncompleteSurvey
    // Map<String, dynamic> responses = sessionInfo.responses;
    // int lastIndexAnswered = 1;
    // responses.forEach((key, value) {
    //   int keyToInteger = int.parse(key.replaceAll("QID", ""));
    //   if (keyToInteger > lastIndexAnswered) {
    //     lastIndexAnswered = keyToInteger;
    //   }
    // });
    // int nextIndex = lastIndexAnswered + 1;
    // QuestionModel question = sessionInfo.questions.firstWhere((question) =>
    //     question.questionId.contains(nextIndex.toString())); // valid

    QuestionModel question =
        await repository.getNextQuestionForIncompleteSurvey();

    emit(
      FillingOutQuestionSurveyState(
        currentQuestionIndex: question.currentIndex,
        question: question,
        totalQuestionCount: sessionInfo.questions.length,
      ),
    );
  }

  nextQuestion(Map answer) async {
    if (state is FillingOutQuestionSurveyState) {
      int nextIndex =
          (state as FillingOutQuestionSurveyState).currentQuestionIndex + 1;

      emit(LoadingSurveyState());

      // REPOSITORY.StoreAnswer()
      // REPOSITORY.getQuestionForIndex (already exists)

      // TODO REMOVE THIS WHEN ADDING INDEX AND TOTAL COUNT TO QUESTION MODEL
      Map<String, dynamic> sessionInfoMap =
          await qualtricsLocal.fetchSurveySession();
      SessionInfoModel sessionInfo = sessionInfoMap['sessionInfoModel'];
      // sessionInfo.responses.addAll(answer);
      // await qualtricsLocal.storeEntireSurveySession(
      //     sessionInfoMap['surveyId'], sessionInfo);
      await repository.storeAnswer(answer);

      QuestionModel nextQuestion =
          await repository.getQuestionForIndex(nextIndex);
      Map<String, dynamic> previousAnswer =
          await repository.getPreviousAnswerByIndex(nextIndex);

      emit(
        FillingOutQuestionSurveyState(
            currentQuestionIndex: nextIndex,
            question: nextQuestion,
            totalQuestionCount: sessionInfo.questions.length,
            previousAnswer: previousAnswer),
      );
    }
  }

  previousQuestion() async {
    if (state is FillingOutQuestionSurveyState) {
      int previousIndex =
          (state as FillingOutQuestionSurveyState).currentQuestionIndex - 1;
      print("previous index: $previousIndex");
      emit(LoadingSurveyState());

      // REPOSITORY.findPreviousAnswerByIndex()
      Map<String, dynamic> sessionInfoMap =
          await qualtricsLocal.fetchSurveySession();
      SessionInfoModel sessionInfo = sessionInfoMap['sessionInfoModel'];
      // String previousAnswerKey = sessionInfo.responses.keys
      //     .firstWhere((key) => key.contains(previousIndex.toString()));
      // Map<String, dynamic> previousAnswer = {
      //   previousAnswerKey: sessionInfo.responses[previousAnswerKey]
      // };
      Map<String, dynamic> previousAnswer =
          await repository.getPreviousAnswerByIndex(previousIndex);

      // REPOSITORY.getQuestionForIndex (already exists)
      // QuestionModel previousQuestion = sessionInfo.questions.firstWhere(
      //     (question) => question.questionId.contains(previousIndex.toString()));
      QuestionModel previousQuestion =
          await repository.getQuestionForIndex(previousIndex);

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

      // REPOSITORY.StoreAnswer
      //TODO data model here
      // Map<String, dynamic> sessionInfoMap =
      //     await qualtricsLocal.fetchSurveySession();
      // SessionInfoModel sessionInfo = sessionInfoMap['sessionInfoModel'];
      // sessionInfo.responses.addAll(answer);
      // await qualtricsLocal.storeEntireSurveySession(
      //     sessionInfoMap['surveyId'], sessionInfo);
      await repository.storeAnswer(answer);

      try {
        await repository.completeSession();
        // final String deviceId = await userLocal.fetchUniqueDeviceID();
        //
        // // REPOSITORY.completeSession()
        // await qualtricsRemote.updateSession(
        //   request: ApiRequestModel(
        //     surveyId: sessionInfoMap['surveyId'],
        //     sessionId: sessionInfo.sessionId,
        //   ),
        //   surveyResponses: SurveyResponsesModel(
        //     answers: sessionInfo.responses,
        //     advance: true,
        //     deviceId: deviceId,
        //   ),
        // );
        // await qualtricsLocal.markSurveyAsComplete(sessionInfoMap['surveyId']);
        // await qualtricsLocal.deleteCurrentSessionData();
        // //todo if survey's beginDate is null or title is Survey_1 update all surveys dates

        emit(ThankYouSurveyState());
      } catch (e) {
        // TODO May want to handle different type of exceptions being thrown.
        // Once case that will happen alot is that they dont have service (NetworkTimeoutException)
        emit(FailureSurveyState(
            "we are unable to submit your survey at this time, Developer note: I recommend implementing a background fetch process that will automatically try to submit a failed survey"));
      }
    }
  }
}
