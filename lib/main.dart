import 'package:flutter/material.dart';
import 'package:libertaspeople/pages/survey_question_page.dart';
import 'package:libertaspeople/pages/survey_thankyou_page.dart';
import 'package:libertaspeople/pages/thankyou_page.dart';

import 'pages/ui_development_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Libertas People',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: UIDevelopmentPage(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => UIDevelopmentPage(),
        SurveyQuestionPage.routeName: (ctx) => SurveyQuestionPage(),
        ThankyouPage.routeName: (ctx) => ThankyouPage(),
        SurveyThankyouPage.routeName: (ctx) => SurveyThankyouPage()
      },
    );
  }
}
