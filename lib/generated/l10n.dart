// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

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

  /// `Workplace ID`
  String get workplaceId {
    return Intl.message(
      'Workplace ID',
      name: 'workplaceId',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get id {
    return Intl.message(
      'ID',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Workplace`
  String get workplace {
    return Intl.message(
      'Workplace',
      name: 'workplace',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Role`
  String get role {
    return Intl.message(
      'Role',
      name: 'role',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the workplace ID that you have been given (by email or by workplace manager)`
  String get pleaseEnterTheWorkplaceIdThat {
    return Intl.message(
      'Please enter the workplace ID that you have been given (by email or by workplace manager)',
      name: 'pleaseEnterTheWorkplaceIdThat',
      desc: '',
      args: [],
    );
  }

  /// `Please enter workplace ID.`
  String get pleaseEnterWorkplaceId {
    return Intl.message(
      'Please enter workplace ID.',
      name: 'pleaseEnterWorkplaceId',
      desc: '',
      args: [],
    );
  }

  /// `What is your gender?`
  String get whatIsYourGender {
    return Intl.message(
      'What is your gender?',
      name: 'whatIsYourGender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Prefer not to say`
  String get preferNotToSay {
    return Intl.message(
      'Prefer not to say',
      name: 'preferNotToSay',
      desc: '',
      args: [],
    );
  }

  /// `Please select an answer.`
  String get pleaseSelectAnAnswer {
    return Intl.message(
      'Please select an answer.',
      name: 'pleaseSelectAnAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Your workplace is`
  String get yourWorkplaceIs {
    return Intl.message(
      'Your workplace is',
      name: 'yourWorkplaceIs',
      desc: '',
      args: [],
    );
  }

  /// `An office or a factory`
  String get anOfficeOrAFactory {
    return Intl.message(
      'An office or a factory',
      name: 'anOfficeOrAFactory',
      desc: '',
      args: [],
    );
  }

  /// `A field or a farm`
  String get aFieldOrAFarm {
    return Intl.message(
      'A field or a farm',
      name: 'aFieldOrAFarm',
      desc: '',
      args: [],
    );
  }

  /// `Which age group are you in?`
  String get whichAgeGroupAreYouIn {
    return Intl.message(
      'Which age group are you in?',
      name: 'whichAgeGroupAreYouIn',
      desc: '',
      args: [],
    );
  }

  /// `< 15 years`
  String get lessThan15Years {
    return Intl.message(
      '< 15 years',
      name: 'lessThan15Years',
      desc: '',
      args: [],
    );
  }

  /// `15-18 years`
  String get from15To18Years {
    return Intl.message(
      '15-18 years',
      name: 'from15To18Years',
      desc: '',
      args: [],
    );
  }

  /// `19-25 years`
  String get from19To25Years {
    return Intl.message(
      '19-25 years',
      name: 'from19To25Years',
      desc: '',
      args: [],
    );
  }

  /// `26-39 years`
  String get from26To39Years {
    return Intl.message(
      '26-39 years',
      name: 'from26To39Years',
      desc: '',
      args: [],
    );
  }

  /// `40-59 years`
  String get from40To59Years {
    return Intl.message(
      '40-59 years',
      name: 'from40To59Years',
      desc: '',
      args: [],
    );
  }

  /// `> 60 years`
  String get moreThan60Years {
    return Intl.message(
      '> 60 years',
      name: 'moreThan60Years',
      desc: '',
      args: [],
    );
  }

  /// `Are you a manager in your department?`
  String get areYouAManagerInYourDepartment {
    return Intl.message(
      'Are you a manager in your department?',
      name: 'areYouAManagerInYourDepartment',
      desc: '',
      args: [],
    );
  }

  /// `yes`
  String get yes {
    return Intl.message(
      'yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `no`
  String get no {
    return Intl.message(
      'no',
      name: 'no',
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