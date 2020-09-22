import 'package:flutter/material.dart';

class AboutSurvey extends StatefulWidget {
  @override
  _AboutSurveyState createState() => _AboutSurveyState();
}

class _AboutSurveyState extends State<AboutSurvey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("This is the About Survey Page"),
      ),
    );
  }
}
