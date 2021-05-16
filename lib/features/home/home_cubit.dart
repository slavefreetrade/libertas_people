import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data_layer/repository.dart';
import '../../models/stored_session_data_model.dart';
import '../../services/notification_service.dart';

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
  final NotificationServiceI notificationService = NotificationService();

  Future<void> loadHomeScreen() async {
    try {
      emit(LoadingHomeScreenState());

      final StoredSessionDataModel storedSessionData =
          await repository.fetchIncompleteSessionData();

      if (storedSessionData != null) {
        notificationService.subscribeToSurveyNotCompletedNotification();
        emit(
          UnfinishedSurveyHomeScreenState(
            storedSessionData.surveyId,
            storedSessionData.sessionInfoModel.sessionId,
          ),
        );
        return;
      }

      // TODO data model
      final Map<String, dynamic> currentSurveyForUser =
          await repository.fetchCurrentSurveyForUser();

      /// completed all surveys
      if (currentSurveyForUser == null) {
        notificationService.subscribeToSurveyCompletedNotification();
        emit(NoSurveyHomeScreenState());
        return;
      }

      final bool currentSurveyIsComplete =
          currentSurveyForUser['isComplete'] as bool;
      final String currentSurveyId = currentSurveyForUser['id'] as String;

      /// Completed current survey but not all
      if (currentSurveyIsComplete) {
        notificationService.subscribeToSurveyCompletedNotification();
        emit(NoSurveyHomeScreenState());
        return;
      }

      if (!currentSurveyIsComplete &&
          currentSurveyForUser['name'] == 'WA_Continuous_1') {
        notificationService.subscribeToSurveyNotOpenedNotification();
        emit(WelcomeFirstTimeHomeScreenState(currentSurveyId));
        return;
      }

      notificationService.subscribeToSurveyNotOpenedNotification();
      emit(WelcomeBackHomeScreenState(currentSurveyId));
    } on Exception catch (e) {
      emit(FailureHomeScreenState(e.toString()));
    }
  }
}
