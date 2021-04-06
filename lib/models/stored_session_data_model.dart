import 'package:json_annotation/json_annotation.dart';
import 'package:libertaspeople/models/session_info_model.dart';
part 'stored_session_data_model.g.dart';

@JsonSerializable()
class StoredSessionDataModel {
  final String surveyId;
  final SessionInfoModel sessionInfoModel;

  StoredSessionDataModel({this.surveyId, this.sessionInfoModel});

  factory StoredSessionDataModel.fromJson(Map<String, dynamic> json) =>
      _$StoredSessionDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoredSessionDataModelToJson(this);

}