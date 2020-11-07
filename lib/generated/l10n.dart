// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `You are invited to take part in the staff survey that plays an important part in monitoring human rights conditions at work places.`
  String get youAreInvitedToTakePartInTheStaffSurveyThatPlaysAn {
    return Intl.message(
      'You are invited to take part in the staff survey that plays an important part in monitoring human rights conditions at work places.',
      name: 'youAreInvitedToTakePartInTheStaffSurveyThatPlaysAn',
      desc: '',
      args: [],
    );
  }

  /// `You will answer 20 multiple choice questions the first time you access the survey.`
  String get youWillAnswer20MultipleChoiceQuestionsTheFirstTimeYouAccessTheSurvey {
    return Intl.message(
      'You will answer 20 multiple choice questions the first time you access the survey.',
      name: 'youWillAnswer20MultipleChoiceQuestionsTheFirstTimeYouAccessTheSurvey',
      desc: '',
      args: [],
    );
  }

  /// `As part of monitoring, you are asked to fill out the survey regularly.`
  String get asPartOfMonitoringYouAreAskedToFillOutTheSurveyRegularly {
    return Intl.message(
      'As part of monitoring, you are asked to fill out the survey regularly.',
      name: 'asPartOfMonitoringYouAreAskedToFillOutTheSurveyRegularly',
      desc: '',
      args: [],
    );
  }

  /// `After the initial survey, you will receive 10 questions each month.`
  String get afterTheInitialSurveyYouWillReceive10QuestionsEachMonth {
    return Intl.message(
      'After the initial survey, you will receive 10 questions each month.',
      name: 'afterTheInitialSurveyYouWillReceive10QuestionsEachMonth',
      desc: '',
      args: [],
    );
  }

  /// `“This month’s survey is ready for you!”`
  String get thisMonthsSurveyIsReadyForYou {
    return Intl.message(
      '“This month’s survey is ready for you!”',
      name: 'thisMonthsSurveyIsReadyForYou',
      desc: '',
      args: [],
    );
  }

  /// `Don’t worry, we’ll notify you when it’s time to update your survey.`
  String get dontWorryWellNotifyYouWhenItsTimeToUpdateYourSurvey {
    return Intl.message(
      'Don’t worry, we’ll notify you when it’s time to update your survey.',
      name: 'dontWorryWellNotifyYouWhenItsTimeToUpdateYourSurvey',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get welcome {
    return Intl.message(
      'Welcome!',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Let's get started!`
  String get letsGetStarted {
    return Intl.message(
      'Let\'s get started!',
      name: 'letsGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previous {
    return Intl.message(
      'Previous',
      name: 'previous',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get complete {
    return Intl.message(
      'Complete',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get information {
    return Intl.message(
      'Information',
      name: 'information',
      desc: '',
      args: [],
    );
  }

  /// `Your valuable input in 5 minutes`
  String get yourValuableInputIn5Minutes {
    return Intl.message(
      'Your valuable input in 5 minutes',
      name: 'yourValuableInputIn5Minutes',
      desc: '',
      args: [],
    );
  }

  /// `Please answer freely based on your  own experiences and observations.`
  String get pleaseAnswerFreelyBasedOnYourOwnExperiencesAndObservations {
    return Intl.message(
      'Please answer freely based on your  own experiences and observations.',
      name: 'pleaseAnswerFreelyBasedOnYourOwnExperiencesAndObservations',
      desc: '',
      args: [],
    );
  }

  /// `Nobody should tell you what to answer or control you when you take the survey.`
  String get nobodyShouldTellYouWhatToAnswerOrControlYouWhenYouTakeTheSurvey {
    return Intl.message(
      'Nobody should tell you what to answer or control you when you take the survey.',
      name: 'nobodyShouldTellYouWhatToAnswerOrControlYouWhenYouTakeTheSurvey',
      desc: '',
      args: [],
    );
  }

  /// `Completing the survey will not expose you to any risk or repercussion with your manager or employer.`
  String get completingTheSurveyWillNotExposeYouToAnyRiskOrRepercussionWithYour {
    return Intl.message(
      'Completing the survey will not expose you to any risk or repercussion with your manager or employer.',
      name: 'completingTheSurveyWillNotExposeYouToAnyRiskOrRepercussionWithYour',
      desc: '',
      args: [],
    );
  }

  /// `Questions marked with a * are obligatory to answer.`
  String get questionsMarkedWithAStarSymbolAreObligatoryToAnswer {
    return Intl.message(
      'Questions marked with a * are obligatory to answer.',
      name: 'questionsMarkedWithAStarSymbolAreObligatoryToAnswer',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}