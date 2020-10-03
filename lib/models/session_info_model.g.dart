// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionInfoModel _$SessionInfoModelFromJson(Map<String, dynamic> json) {
  return SessionInfoModel(
    sessionId: json['sessionId'] as String,
    questions: (json['questions'] as List)
        .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    done: json['done'] as bool,
  );
}

Map<String, dynamic> _$SessionInfoModelToJson(SessionInfoModel instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
      'done': instance.done,
    };
