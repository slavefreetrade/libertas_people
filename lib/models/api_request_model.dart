import 'package:json_annotation/json_annotation.dart';

part 'api_request_model.g.dart';

@JsonSerializable(nullable: false)
class ApiRequestModel {
  String sessionId;

  @JsonKey(nullable: true, includeIfNull: false)
  String surveyId;

  ApiRequestModel({this.sessionId, this.surveyId});
  factory ApiRequestModel.fromJson(Map<String, dynamic> json) => _$ApiRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$ApiRequestModelToJson(this);
}
