import 'package:json_annotation/json_annotation.dart';

part 'choice_model.g.dart';

@JsonSerializable(nullable: false)
class ChoiceModel {
  String choiceId;
  String display;
  bool textual;

  ChoiceModel({this.choiceId, this.display, this.textual});
  factory ChoiceModel.fromJson(Map<String, dynamic> json) => _$ChoiceModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChoiceModelToJson(this);
}
