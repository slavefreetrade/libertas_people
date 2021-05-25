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

  Future<void> startSurvey(String surveyId) async {
    if (state is LoadingSurveyState) return;
    emit(LoadingSurveyState());

    final SessionInfoModel session = await repository.startSession(surveyId);

    final QuestionModel question = await repository.getQuestionForIndex(1);

    emit(
      FillingOutQuestionSurveyState(
          currentQuestionIndex: question.currentIndex,
          question: question,
          totalQuestionCount: session.questions.length),
    );
  }

  Future<void> returnToIncompleteSurveySession({
    @required String surveyId,
    @required String sessionId,
  }) async {
    if (state is LoadingSurveyState) return;
    emit(LoadingSurveyState());

    final SessionInfoModel sessionInfo =
        await repository.returnToPreviousSession();

    final QuestionModel question =
        await repository.getNextQuestionForIncompleteSurvey();

    emit(
      FillingOutQuestionSurveyState(
        currentQuestionIndex: question.currentIndex,
        question: question,
        totalQuestionCount: sessionInfo.questions.length,
      ),
    );
  }

  Future<void> nextQuestion(Map<String, dynamic> answer) async {
    if (state is FillingOutQuestionSurveyState) {
      final nextIndex =
          (state as FillingOutQuestionSurveyState).currentQuestionIndex + 1;
      final totalQuestionCount =
          (state as FillingOutQuestionSurveyState).totalQuestionCount;

      emit(LoadingSurveyState());

      await repository.storeAnswer(answer);

      final nextQuestion = await repository.getQuestionForIndex(nextIndex);
      final previousAnswer =
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

  Future<void> previousQuestion() async {
    if (state is FillingOutQuestionSurveyState) {
      final int previousIndex =
          (state as FillingOutQuestionSurveyState).currentQuestionIndex - 1;
      final int totalQuestionCount =
          (state as FillingOutQuestionSurveyState).totalQuestionCount;
      emit(LoadingSurveyState());

      final Map<String, dynamic> previousAnswer =
          await repository.getPreviousAnswerByIndex(previousIndex);

      final QuestionModel previousQuestion =
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

  Future<void> completeSurvey(Map<String, dynamic> answer) async {
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
            "We are unable to submit your survey at this time."));
      }
    }
  }
}
