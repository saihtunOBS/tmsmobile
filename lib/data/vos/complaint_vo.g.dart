// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplaintVO _$ComplaintVOFromJson(Map<String, dynamic> json) => ComplaintVO(
      id: json['_id'] as String?,
      complaint: json['complaint'] as String?,
      status: (json['status'] as num?)?.toInt(),
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      tenant: json['tenant'] as String?,
      businessUnit: json['business_unit'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ComplaintVOToJson(ComplaintVO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'complaint': instance.complaint,
      'photos': instance.photos,
      'status': instance.status,
      'tenant': instance.tenant,
      'business_unit': instance.businessUnit,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
    };
