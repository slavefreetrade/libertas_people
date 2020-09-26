import 'package:flutter/widgets.dart';

class ProfileFormQuestionModel {
  String question;
  List<String> options;
  int selectedIndex;
  bool isOptional;

  ProfileFormQuestionModel({
    @required this.question,
    @required this.options,
    this.selectedIndex,
    this.isOptional = false
  });
}
