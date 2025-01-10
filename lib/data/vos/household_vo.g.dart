// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseHoldVO _$HouseHoldVOFromJson(Map<String, dynamic> json) => HouseHoldVO(
      id: json['_id'] as String,
      registerDate: DateTime.parse(json['register_date'] as String),
      moveInDate: DateTime.parse(json['move_in_date'] as String),
      emergencyContactNumber: json['emergency_contact_number'] as String,
      information: (json['information'] as List<dynamic>)
          .map((e) => HouseHoldInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
      tenant: json['tenant'] as String,
      businessUnit: json['business_unit'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$HouseHoldVOToJson(HouseHoldVO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'register_date': instance.registerDate.toIso8601String(),
      'move_in_date': instance.moveInDate.toIso8601String(),
      'emergency_contact_number': instance.emergencyContactNumber,
      'information': instance.information,
      'tenant': instance.tenant,
      'business_unit': instance.businessUnit,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.version,
    };
