// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyVO _$SurveyVOFromJson(Map<String, dynamic> json) => SurveyVO(
      status: (json['status'] as num?)?.toInt(),
      surveyDate: json['survey_date'] as String?,
      event: json['event'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SurveyVOToJson(SurveyVO instance) => <String, dynamic>{
      'status': instance.status,
      'survey_date': instance.surveyDate,
      'event': instance.event,
      'message': instance.message,
    };
