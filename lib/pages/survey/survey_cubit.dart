import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/models/question_model.dart';

abstract class SurveyState {}

class UninitialzedSurveyState extends SurveyState {}

class LoadingSurveyState extends SurveyState {}

// to display first 2 pages
class BeginSurveyState extends SurveyState {}

class FillingOutQuestionSurveyState extends SurveyState {
  final String currentQuestionIndex;
  final String previousQuestionIndex;
  // maybe next index too;

  final QuestionModel question;

  FillingOutQuestionSurveyState({
    @required this.currentQuestionIndex,
    @required this.previousQuestionIndex,
    @required this.question,
  });
}

class ThankYouSurveyState extends SurveyState {}

class FailureSurveyState extends SurveyState {}

class SurveyCubit extends Cubit<SurveyState> {
  SurveyCubit() : super(UninitialzedSurveyState());

  // could store survey ID and session ID globally because they wont change

  startSurvey(String surveyId) {}

  returnToIncompletedSurveySession(String surveyId, String surveySessionId) {}

  answerQuestion() {}

  completeSurvey() {}
}
