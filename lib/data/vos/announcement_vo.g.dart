// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnouncementVO _$AnnouncementVOFromJson(Map<String, dynamic> json) =>
    AnnouncementVO(
      id: json['_id'] as String?,
      sendTo: (json['sendTo'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      businessUnit: json['business_unit'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AnnouncementVOToJson(AnnouncementVO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'sendTo': instance.sendTo,
      'title': instance.title,
      'description': instance.description,
      'photos': instance.photos,
      'business_unit': instance.businessUnit,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
    };
