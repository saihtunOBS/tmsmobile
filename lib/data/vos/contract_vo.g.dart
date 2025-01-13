// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractVo _$ContractVoFromJson(Map<String, dynamic> json) => ContractVo(
      id: json['_id'] as String?,
      tenant: json['tenant'] == null
          ? null
          : Tenant.fromJson(json['tenant'] as Map<String, dynamic>),
      propertyType: json['property_type'] as String?,
    );

Map<String, dynamic> _$ContractVoToJson(ContractVo instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'tenant': instance.tenant,
      'property_type': instance.propertyType,
    };
