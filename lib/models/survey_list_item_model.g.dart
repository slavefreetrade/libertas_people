// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_list_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyListModel _$SurveyListModelFromJson(Map<String, dynamic> json) {
  return SurveyListModel(
    surveys: (json['surveys'] as List)
        .map((e) => SurveyListItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SurveyListModelToJson(SurveyListModel instance) =>
    <String, dynamic>{
      'surveys': instance.surveys.map((e) => e.toJson()).toList(),
    };

SurveyListItemModel _$SurveyListItemModelFromJson(Map<String, dynamic> json) {
  return SurveyListItemModel(
    id: json['id'] as String,
    name: json['name'] as String,
    isActive: json['isActive'] as bool,
  );
}

Map<String, dynamic> _$SurveyListItemModelToJson(
        SurveyListItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isActive': instance.isActive,
    };
