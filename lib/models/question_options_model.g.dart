// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_options_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionOptionsModel _$QuestionOptionsModelFromJson(Map<String, dynamic> json) {
  return QuestionOptionsModel(
    columnLabels:
        (json['columnLabels'] as List)?.map((e) => e as String)?.toList(),
    multiSelect: json['multiSelect'] as bool,
  );
}

Map<String, dynamic> _$QuestionOptionsModelToJson(
    QuestionOptionsModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('columnLabels', instance.columnLabels);
  writeNotNull('multiSelect', instance.multiSelect);
  return val;
}
