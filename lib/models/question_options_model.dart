import 'package:json_annotation/json_annotation.dart';

part 'question_options_model.g.dart';

@JsonSerializable()
class QuestionOptionsModel {
  @JsonKey(includeIfNull: false)
  List<String> columnLabels;

  @JsonKey(includeIfNull: false)
  bool multiSelect;

  QuestionOptionsModel({this.columnLabels, this.multiSelect});
  factory QuestionOptionsModel.fromJson(Map<String, dynamic> json) => _$QuestionOptionsModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionOptionsModelToJson(this);
}
