// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChoiceModel _$ChoiceModelFromJson(Map<String, dynamic> json) {
  return ChoiceModel(
    choiceId: json['choiceId'] as String,
    display: json['display'] as String,
    textual: json['textual'] as bool,
  );
}

Map<String, dynamic> _$ChoiceModelToJson(ChoiceModel instance) =>
    <String, dynamic>{
      'choiceId': instance.choiceId,
      'display': instance.display,
      'textual': instance.textual,
    };
