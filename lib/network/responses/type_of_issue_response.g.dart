// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_of_issue_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeOfIssueResponse _$TypeOfIssueResponseFromJson(Map<String, dynamic> json) =>
    TypeOfIssueResponse(
      status: json['success'] as bool?,
      message: json['messaage'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TypeOfIssueVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TypeOfIssueResponseToJson(
        TypeOfIssueResponse instance) =>
    <String, dynamic>{
      'success': instance.status,
      'messaage': instance.message,
      'data': instance.data,
    };
