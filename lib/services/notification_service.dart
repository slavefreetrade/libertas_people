import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService extends NotificationServiceI {
  @override
  Future<void> subscribeToSurveyNotOpenedNotification() async {
    await Future.wait([
      FirebaseMessaging.instance
          .subscribeToTopic(_NotificationTopic.surveyNotOpened),
      FirebaseMessaging.instance
          .unsubscribeFromTopic(_NotificationTopic.surveyNotCompleted),
      FirebaseMessaging.instance
          .unsubscribeFromTopic(_NotificationTopic.surveyCompleted),
      FirebaseMessaging.instance
          .unsubscribeFromTopic(_NotificationTopic.onBoardingNotCompleted),
    ], eagerError: true);
  }

  @override
  Future<void> subscribeToSurveyNotCompletedNotification() async {
    await Future.wait([
      FirebaseMessaging.instance
          .subscribeToTopic(_NotificationTopic.surveyNotCompleted),
      FirebaseMessaging.instance
          .unsubscribeFromTopic(_NotificationTopic.surveyNotOpened),
      FirebaseMessaging.instance
          .unsubscribeFromTopic(_NotificationTopic.surveyCompleted),
    ], eagerError: true);
  }

  @override
  Future<void> subscribeToSurveyCompletedNotification() async {
    await Future.wait([
      FirebaseMessaging.instance
          .subscribeToTopic(_NotificationTopic.surveyCompleted),
      FirebaseMessaging.instance
          .unsubscribeFromTopic(_NotificationTopic.surveyNotCompleted),
      FirebaseMessaging.instance
          .unsubscribeFromTopic(_NotificationTopic.surveyNotOpened),
    ], eagerError: true);
  }

  @override
  Future<void> subscribeToOnBoardingNotCompletedNotification() async {
    await Future.wait([
      FirebaseMessaging.instance
          .subscribeToTopic(_NotificationTopic.onBoardingNotCompleted),
    ], eagerError: true);
  }
}

abstract class NotificationServiceI {
  Future<void> subscribeToSurveyNotOpenedNotification();

  Future<void> subscribeToSurveyNotCompletedNotification();

  Future<void> subscribeToSurveyCompletedNotification();

  Future<void> subscribeToOnBoardingNotCompletedNotification();
}

class _NotificationTopic {
  static const String surveyNotCompleted = 'survey_not_completed';
  static const String surveyCompleted = 'survey_completed';
  static const String surveyNotOpened = 'survey_not_opened';
  static const String onBoardingNotCompleted = 'on_boarding_not_completed';
}
