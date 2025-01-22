// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_of_issue_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeOfIssueVO _$TypeOfIssueVOFromJson(Map<String, dynamic> json) =>
    TypeOfIssueVO(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      businessUnit: json['business_unit'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TypeOfIssueVOToJson(TypeOfIssueVO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'business_unit': instance.businessUnit,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
    };
