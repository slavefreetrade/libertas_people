import 'package:flutter/material.dart';

class SurveyResponsesModel {
  Map<String, dynamic> answers;
  bool advance;
  String deviceId;

  SurveyResponsesModel(
      {@required this.answers,
      @required this.advance,
      @required this.deviceId});
}
