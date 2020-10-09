// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) {
  return QuestionModel(
    questionId: json['questionId'] as String,
    type: _$enumDecode(_$QuestionTypeEnumMap, json['type']),
    display: json['display'] as String,
    choices: (json['choices'] as List)
        ?.map((e) =>
            e == null ? null : ChoiceModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    options:
        QuestionOptionsModel.fromJson(json['options'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) {
  final val = <String, dynamic>{
    'questionId': instance.questionId,
    'type': _$QuestionTypeEnumMap[instance.type],
    'display': instance.display,
    'options': instance.options.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('choices', instance.choices?.map((e) => e?.toJson())?.toList());
  return val;
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

const _$QuestionTypeEnumMap = {
  QuestionType.mc: 'mc',
  QuestionType.te: 'te',
  QuestionType.db: 'db',
};
