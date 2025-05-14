// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractVO _$ContractVOFromJson(Map<String, dynamic> json) => ContractVO(
      id: json['_id'] as String?,
      tenant: json['tenant'] == null
          ? null
          : Tenant.fromJson(json['tenant'] as Map<String, dynamic>),
      propertyType: json['property_type'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ContractVOToJson(ContractVO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'tenant': instance.tenant,
      'property_type': instance.propertyType,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
