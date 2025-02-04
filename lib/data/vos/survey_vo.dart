
import 'package:json_annotation/json_annotation.dart';
part 'survey_vo.g.dart';

@JsonSerializable()
class SurveyVO {
  final int? status;
  @JsonKey(name: "survey_date")
  final String? surveyDate;
  final String? event;
  final String? message;

  SurveyVO({this.status, this.surveyDate, this.event, this.message});

  factory SurveyVO.fromJson(Map<String, dynamic> json) =>
      _$SurveyVOFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyVOToJson(this);
}