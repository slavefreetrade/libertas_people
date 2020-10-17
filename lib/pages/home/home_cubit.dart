import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/data_layer/repository.dart';
import 'package:libertaspeople/models/stored_session_data_model.dart';

abstract class HomeScreenState {}

class UninitializedHomeScreenState extends HomeScreenState {}

class LoadingHomeScreenState extends HomeScreenState {}

class FailureHomeScreenState extends HomeScreenState {
  final String message;

  FailureHomeScreenState(this.message);
}

class WelcomeFirstTimeHomeScreenState extends HomeScreenState {
  final String firstSurveyId;

  WelcomeFirstTimeHomeScreenState(this.firstSurveyId);
}

class NoSurveyHomeScreenState extends HomeScreenState {}

class WelcomeBackHomeScreenState extends HomeScreenState {
  final String surveyId;

  WelcomeBackHomeScreenState(this.surveyId);
}

class UnfinishedSurveyHomeScreenState extends HomeScreenState {
  final String surveyId;
  final String sessionId;

  UnfinishedSurveyHomeScreenState(
    this.surveyId,
    this.sessionId,
  );
}

/// After you emit a state from Cubit, and you want to stop the function from
/// emitting a new state, make sure you call return; after emit();

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(UninitializedHomeScreenState());

  final Repository repository = Repository();

  loadHomeScreen() async {
    try {
      emit(LoadingHomeScreenState());

      final StoredSessionDataModel storedSessionData =
          await repository.fetchIncompleteSessionData();

      if (storedSessionData != null) {
        emit(
          UnfinishedSurveyHomeScreenState(
            storedSessionData.surveyId,
            storedSessionData.sessionInfoModel.sessionId,
          ),
        );
        return;
      }

      Map<String, dynamic> currentSurveyForUser =
          await repository.fetchCurrentSurveyForUser();

      /// completed all surveys
      if (currentSurveyForUser == null) {
        emit(NoSurveyHomeScreenState());
        return;
      }

      bool currentSurveyIsComplete = currentSurveyForUser['isComplete'];
      String currentSurveyId = currentSurveyForUser['id'];

      if (currentSurveyIsComplete) {
        emit(NoSurveyHomeScreenState());
        return;
      }

      if (!currentSurveyIsComplete &&
          currentSurveyForUser['name'] == "Survey_1") {
        emit(WelcomeFirstTimeHomeScreenState(currentSurveyId));
        return;
      }

      emit(WelcomeBackHomeScreenState(currentSurveyId));
    } catch (e) {
      print(e);
      emit(FailureHomeScreenState(e.toString()));
    }
  }
}
