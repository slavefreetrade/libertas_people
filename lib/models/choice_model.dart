import 'package:json_annotation/json_annotation.dart';

part 'choice_model.g.dart';

@JsonSerializable()
class ChoiceModel {
  String choiceId;
  String display;
  bool textual;

  ChoiceModel({this.choiceId, this.display, this.textual});
  factory ChoiceModel.fromJson(Map<String, dynamic> json) => _$ChoiceModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChoiceModelToJson(this);
}
