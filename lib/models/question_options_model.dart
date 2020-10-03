import 'package:json_annotation/json_annotation.dart';

part 'question_options_model.g.dart';

@JsonSerializable(nullable: true)
class QuestionOptionsModel {
  @JsonKey(nullable: true, includeIfNull: false)
  List<String> columnLabels;

  @JsonKey(nullable: true, includeIfNull: false)
  bool multiSelect;

  QuestionOptionsModel({this.columnLabels, this.multiSelect});
  factory QuestionOptionsModel.fromJson(Map<String, dynamic> json) => _$QuestionOptionsModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionOptionsModelToJson(this);
}
