// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaintenanceVO _$MaintenanceVOFromJson(Map<String, dynamic> json) =>
    MaintenanceVO(
      id: json['_id'] as String?,
      tenant: json['tenant'] == null
          ? null
          : Tenant.fromJson(json['tenant'] as Map<String, dynamic>),
      issue: json['issue'] as String?,
      description: json['description'] as String?,
      shop: json['shop'] == null
          ? null
          : Shop.fromJson(json['shop'] as Map<String, dynamic>),
      businessUnit: json['business_unit'] as String?,
      attach:
          (json['attach'] as List<dynamic>?)?.map((e) => e as String).toList(),
      status: (json['status'] as num?)?.toInt(),
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MaintenanceVOToJson(MaintenanceVO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'tenant': instance.tenant,
      'issue': instance.issue,
      'description': instance.description,
      'shop': instance.shop,
      'business_unit': instance.businessUnit,
      'attach': instance.attach,
      'status': instance.status,
      '__v': instance.version,
    };
