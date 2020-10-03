import 'package:json_annotation/json_annotation.dart';
import 'package:libertaspeople/models/question_options_model.dart';

import 'choice_model.dart';

part 'question_model.g.dart';

@JsonSerializable(nullable: false, explicitToJson: true)
class QuestionModel {
  String questionId;
  QuestionType type;
  String display;
  QuestionOptionsModel options;

  @JsonKey(nullable: true, includeIfNull: false)
  List<ChoiceModel> choices;

  QuestionModel({this.questionId, this.type, this.display, this.choices, this.options});
  factory QuestionModel.fromJson(Map<String, dynamic> json) => _$QuestionModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}

/// mc: multiple choice, te: text entry, db: descriptive bloc
enum QuestionType {mc, te, db}
