import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/data_layer/qualtrics_data_sources/qualtrics_local_data_source.dart';
import 'package:libertaspeople/data_layer/qualtrics_data_sources/qualtrics_remote_data_source.dart';
import 'package:libertaspeople/data_layer/user_data_sources/user_local_data_source.dart';
import 'package:libertaspeople/models/survey_list_item_model.dart';

abstract class HomeScreenState {}

class UninitializedHomeScreenState extends HomeScreenState {}

class LoadingHomeScreenState extends HomeScreenState {}

class FailureHomeScreenState extends HomeScreenState {
  final String message;

  FailureHomeScreenState(this.message);
}

class WelcomeHomeScreenState extends HomeScreenState {
  final String firstSurveyId;

  WelcomeHomeScreenState(this.firstSurveyId);
}

class NoSurveyHomeScreenState extends HomeScreenState {}

class WelcomeBackHomeScreenState extends HomeScreenState {
  final String surveyId;

  WelcomeBackHomeScreenState(this.surveyId);
}

class UnfinishedSurveyHomeScreenState extends HomeScreenState {
  final String surveyID;
  final String sessionId;

  UnfinishedSurveyHomeScreenState(this.surveyID, this.sessionId);
}

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(UninitializedHomeScreenState());

  QualtricsRemoteDataSource qualtricsRemote = QualtricsRemoteDataSource();
  QualtricsLocalDataSource qualtricsLocal = QualtricsLocalDataSource();
  UserLocalDataSource userLocal = UserLocalDataSource();

  loadHomeScreen() async {
    try {
      emit(LoadingHomeScreenState());

      List<dynamic> surveyListFromQualtrics =
          await qualtricsRemote.getListOfAvailableSurveys();
      surveyListFromQualtrics.forEach((survey) => print(survey));
      await qualtricsLocal.storeSurveyList(surveyListFromQualtrics);

      await Future.delayed(Duration(seconds: 1));

      // Could be a use case refactored into a repository
      Map<String, dynamic> storedSessionMetaData =
          await qualtricsLocal.getStoredSessionMetaData;
      if (storedSessionMetaData.containsKey("sessionID") &&
          storedSessionMetaData.containsKey("surveyID")) {
        emit(
          UnfinishedSurveyHomeScreenState(
            storedSessionMetaData['surveyID'],
            storedSessionMetaData['sessionID'],
          ),
        );
        return;
      }

      // Fetch first surveyID if incomplete
      // Could be refactored into a repositroy
      List<dynamic> listOfSurveys = await qualtricsLocal.fetchSurveyList();
      // Map<String, dynamic> firstSurvey =
      //     listOfSurveys.firstWhere((survey) => survey['name'] == "Survey_1");
      // if (firstSurvey["isComplete"] == false) {
      //   emit(WelcomeHomeScreenState(firstSurvey['id']));
      //   return;
      // }

      final DateTime now = DateTime.now();

      Map<String, dynamic> currentSurveyForUser =
          listOfSurveys.firstWhere((survey) {
        DateTime beginningSurveyDate = DateTime.parse(survey["beginDate"]);
        DateTime endSurveyDate = DateTime.parse(survey["finalDate"]);
        return (now.isAfter(beginningSurveyDate) &&
            now.isBefore(endSurveyDate));
      });

      print('currentSurveyForUser: $currentSurveyForUser');

      bool currentSurveyIsComplete = currentSurveyForUser['isComplete'];
      String currentSurveyId = currentSurveyForUser['id'];

      if (currentSurveyIsComplete) {
        emit(NoSurveyHomeScreenState());
        return;
      }

      emit(WelcomeBackHomeScreenState(currentSurveyId));
    } catch (e) {
      emit(FailureHomeScreenState(e.toString()));
    }
  }
}
