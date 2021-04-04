import 'package:json_annotation/json_annotation.dart';

part 'survey_list_item_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SurveyListModel {
  List<SurveyListItemModel> elements;

  SurveyListModel({this.elements});
  factory SurveyListModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyListModelFromJson(json);
  Map<String, dynamic> toJson() => _$SurveyListModelToJson(this);
}

@JsonSerializable()
class SurveyListItemModel {
  String id;
  String name;
  bool isActive;

  SurveyListItemModel({this.id, this.name, this.isActive});
  factory SurveyListItemModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyListItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$SurveyListItemModelToJson(this);
}
