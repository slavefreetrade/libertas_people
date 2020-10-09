import 'package:flutter/material.dart';

class UnfinishedSurvey extends StatelessWidget {
  final String surveyID;
  final String sessionID;

  UnfinishedSurvey({
    @required this.surveyID,
    @required this.sessionID,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [Text("unifishedSurvey finiafgnag;lans")],
    ));
  }
}
