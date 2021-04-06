import 'package:json_annotation/json_annotation.dart';
import 'question_model.dart';

part 'session_info_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SessionInfoModel {
  String sessionId;
  List<QuestionModel> questions;
  bool done;

  @JsonKey(includeIfNull: true)
  Map<String, dynamic> responses;

  SessionInfoModel({this.sessionId, this.questions, this.done, this.responses});
  factory SessionInfoModel.fromJson(Map<String, dynamic> json) =>
      _$SessionInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$SessionInfoModelToJson(this);
}
