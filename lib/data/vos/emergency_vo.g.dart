// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyVO _$EmergencyVOFromJson(Map<String, dynamic> json) => EmergencyVO(
      id: json['_id'] as String?,
      contractName: json['contract_name'] as String?,
      address: json['address'] as String?,
      phone1: json['phone_1'] as String?,
      phone2: json['phone_2'] as String?,
      contractRef: json['contract_ref'] as String?,
      emergencyCategory: json['emergency_category'] == null
          ? null
          : EmergencyCategory.fromJson(
              json['emergency_category'] as Map<String, dynamic>),
      businessUnit: json['business_unit'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EmergencyVOToJson(EmergencyVO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'contract_name': instance.contractName,
      'address': instance.address,
      'phone_1': instance.phone1,
      'phone_2': instance.phone2,
      'contract_ref': instance.contractRef,
      'emergency_category': instance.emergencyCategory,
      'business_unit': instance.businessUnit,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
    };

EmergencyCategory _$EmergencyCategoryFromJson(Map<String, dynamic> json) =>
    EmergencyCategory(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$EmergencyCategoryToJson(EmergencyCategory instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };
