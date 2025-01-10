// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceRequestVo _$ServiceRequestVoFromJson(Map<String, dynamic> json) =>
    ServiceRequestVo(
      id: json['_id'] as String?,
      tenant: json['tenant'] == null
          ? null
          : Tenant.fromJson(json['tenant'] as Map<String, dynamic>),
      shop: json['shop'] == null
          ? null
          : Shop.fromJson(json['shop'] as Map<String, dynamic>),
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

Map<String, dynamic> _$ServiceRequestVoToJson(ServiceRequestVo instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'tenant': instance.tenant,
      'shop': instance.shop,
      'photos': instance.photos,
      'business_unit': instance.businessUnit,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
    };

Tenant _$TenantFromJson(Map<String, dynamic> json) => Tenant(
      id: json['_id'] as String?,
      tenantName: json['tenant_name'] as String?,
    );

Map<String, dynamic> _$TenantToJson(Tenant instance) => <String, dynamic>{
      '_id': instance.id,
      'tenant_name': instance.tenantName,
    };

Shop _$ShopFromJson(Map<String, dynamic> json) => Shop(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ShopToJson(Shop instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };
