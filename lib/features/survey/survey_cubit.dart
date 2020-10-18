import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/data_layer/qualtrics_data_sources/qualtrics_local_data_source.dart';
import 'package:libertaspeople/data_layer/qualtrics_data_sources/qualtrics_remote_data_source.dart';
import 'package:libertaspeople/data_layer/repository.dart';
import 'package:libertaspeople/data_layer/user_data_sources/user_local_data_source.dart';
import 'package:libertaspeople/models/question_model.dart';
import 'package:libertaspeople/models/session_info_model.dart';

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

    SessionInfoModel session = await repository.startSession(surveyId);

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

    SessionInfoModel sessionInfo = await repository.returnToPreviousSession();

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
      int totalQuestionCount = (state as FillingOutQuestionSurveyState).totalQuestionCount;

      emit(LoadingSurveyState());

      await repository.storeAnswer(answer);

      QuestionModel nextQuestion =
          await repository.getQuestionForIndex(nextIndex);
      Map<String, dynamic> previousAnswer =
          await repository.getPreviousAnswerByIndex(nextIndex);

      emit(
        FillingOutQuestionSurveyState(
            currentQuestionIndex: nextIndex,
            question: nextQuestion,
            totalQuestionCount: totalQuestionCount,
            previousAnswer: previousAnswer),
      );
    }
  }

  previousQuestion() async {
    if (state is FillingOutQuestionSurveyState) {
      int previousIndex =
          (state as FillingOutQuestionSurveyState).currentQuestionIndex - 1;
      int totalQuestionCount = (state as FillingOutQuestionSurveyState).totalQuestionCount;
      emit(LoadingSurveyState());

      Map<String, dynamic> previousAnswer =
          await repository.getPreviousAnswerByIndex(previousIndex);

      QuestionModel previousQuestion =
          await repository.getQuestionForIndex(previousIndex);

      emit(
        FillingOutQuestionSurveyState(
          currentQuestionIndex: previousIndex,
          question: previousQuestion,
          totalQuestionCount: totalQuestionCount,
          previousAnswer: previousAnswer,
        ),
      );
    }
  }

  completeSurvey(Map answer) async {
    if (state is FillingOutQuestionSurveyState) {
      emit(LoadingSurveyState());

      await repository.storeAnswer(answer);

      try {
        await repository.completeSession();
        // //todo if survey's beginDate is null or title is Survey_1 update all surveys dates

        emit(ThankYouSurveyState());
      } catch (e) {
        // TODO May want to handle different type of exceptions being thrown.
        emit(FailureSurveyState(
            "we are unable to submit your survey at this time, Developer note: I recommend implementing a background fetch process that will automatically try to submit a failed survey"));
      }
    }
  }
}
