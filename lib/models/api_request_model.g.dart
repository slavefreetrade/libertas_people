// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiRequestModel _$ApiRequestModelFromJson(Map<String, dynamic> json) {
  return ApiRequestModel(
    sessionId: json['sessionId'] as String,
    surveyId: json['surveyId'] as String,
  );
}

Map<String, dynamic> _$ApiRequestModelToJson(ApiRequestModel instance) {
  final val = <String, dynamic>{
    'sessionId': instance.sessionId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('surveyId', instance.surveyId);
  return val;
}
