// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_session_meta_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoredSessionMetaDataModel _$StoredSessionMetaDataModelFromJson(
    Map<String, dynamic> json) {
  return StoredSessionMetaDataModel(
    sessionId: json['sessionId'] as String,
    surveyId: json['surveyId'] as String,
  );
}

Map<String, dynamic> _$StoredSessionMetaDataModelToJson(
        StoredSessionMetaDataModel instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'surveyId': instance.surveyId,
    };
