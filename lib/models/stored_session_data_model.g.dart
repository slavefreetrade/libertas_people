// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_session_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoredSessionDataModel _$StoredSessionDataModelFromJson(
    Map<String, dynamic> json) {
  return StoredSessionDataModel(
    surveyId: json['surveyId'] as String,
    sessionInfoModel: SessionInfoModel.fromJson(
        json['sessionInfoModel'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$StoredSessionDataModelToJson(
        StoredSessionDataModel instance) =>
    <String, dynamic>{
      'surveyId': instance.surveyId,
      'sessionInfoModel': instance.sessionInfoModel,
    };
