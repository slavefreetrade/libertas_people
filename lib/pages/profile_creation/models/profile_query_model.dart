import 'package:flutter/widgets.dart';

class ProfileFormQuestionModel {
  String title;
  String question;
  List<String> options;
  String progressLabel;
  int selectedIndex;
  bool isOptional;

  ProfileFormQuestionModel({
    @required this.title,
    @required this.question,
    @required this.options,
    this.progressLabel = '',
    this.selectedIndex,
    this.isOptional = false
  });
}
