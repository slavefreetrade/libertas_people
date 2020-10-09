import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libertaspeople/data_layer/qualtrics_data_sources/qualtrics_local_data_source.dart';
import 'package:libertaspeople/data_layer/qualtrics_data_sources/qualtrics_remote_data_source.dart';
import 'package:libertaspeople/data_layer/user_data_sources/user_local_data_source.dart';

abstract class HomeScreenState {}

class UninitializedHomeScreenState extends HomeScreenState {}

class LoadingHomeScreenState extends HomeScreenState {}

class WelcomeHomeScreenState extends HomeScreenState {
  final String surveyId;

  WelcomeHomeScreenState(this.surveyId);
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
    emit(LoadingHomeScreenState());

    await Future.delayed(Duration(seconds: 1));

    Map<String, dynamic> storedSessionMetaData =
        await qualtricsLocal.getStoredSessionMetaData;

    storedSessionMetaData['sessionID'] = "session id test";
    storedSessionMetaData['surveyID'] = "s;dlgkasg;lnka;glkn";

    if (storedSessionMetaData.containsKey("sessionID") &&
        storedSessionMetaData.containsKey("surveyID")) {
      emit(
        UnfinishedSurveyHomeScreenState(
          storedSessionMetaData['surveyID'],
          storedSessionMetaData['sessionID'],
        ),
      );
    }

    // this is where I call all of the logic to determine what screen to show

    /*getCurrentSessionModel (Qulatrics local)

if model has a sessionID and a surveyID (a session has not been completed)
so display the “Finish survey Page”

if model is empty
fetch list of surveys (qualtrics local)
if first survey has not been completed -> Display Welcome onboard

next, find the next survey in survey list that pertains to todays date
if that survey has been completed -> display No Surveys At the Moment
if that survey has !completed -> display Welcome Back


 */
  }
}
