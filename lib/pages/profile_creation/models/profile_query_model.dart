import 'package:flutter/widgets.dart';

class ProfileFormQuestionModel {
  String title;
  List<String> options;
  int selectedIndex;
  bool isRequired;

  ProfileFormQuestionModel({
    @required this.title,
    this.selectedIndex,
    this.options = const <String>[],
    this.isRequired = true
  });
}
