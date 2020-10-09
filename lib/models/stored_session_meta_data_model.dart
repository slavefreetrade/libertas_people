import 'package:json_annotation/json_annotation.dart';
part 'stored_session_meta_data_model.g.dart';

@JsonSerializable(nullable: false)
class StoredSessionMetaDataModel {
  final String sessionId;
  final String surveyId;

  StoredSessionMetaDataModel({this.sessionId, this.surveyId});

  factory StoredSessionMetaDataModel.fromJson(Map<String, dynamic> json) =>
      _$StoredSessionMetaDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoredSessionMetaDataModelToJson(this);

}