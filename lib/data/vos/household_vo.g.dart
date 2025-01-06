// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseHoldVO _$HouseHoldVOFromJson(Map<String, dynamic> json) => HouseHoldVO(
      owner: json['owner'] == null
          ? null
          : OwnerVO.fromJson(json['owner'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      registerDate: json['register_date'] == null
          ? null
          : DateTime.parse(json['register_date'] as String),
      moveInDate: json['move_in_date'] == null
          ? null
          : DateTime.parse(json['move_in_date'] as String),
      emergencyContactNumber: json['emergency_contact_number'] as String?,
      resident: (json['resident'] as List<dynamic>?)
          ?.map((e) => ResidentVO.fromJson(e as Map<String, dynamic>))
          .toList(),
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

Map<String, dynamic> _$HouseHoldVOToJson(HouseHoldVO instance) =>
    <String, dynamic>{
      'owner': instance.owner,
      '_id': instance.id,
      'register_date': instance.registerDate?.toIso8601String(),
      'move_in_date': instance.moveInDate?.toIso8601String(),
      'emergency_contact_number': instance.emergencyContactNumber,
      'resident': instance.resident,
      'tenant': instance.tenant,
      'business_unit': instance.businessUnit,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.version,
    };

OwnerVO _$OwnerVOFromJson(Map<String, dynamic> json) => OwnerVO(
      ownerName: json['owner_name'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: json['date_of_birth'] == null
          ? null
          : DateTime.parse(json['date_of_birth'] as String),
      race: json['race'] as String?,
      nationality: json['nationality'] as String?,
      nrc: json['nrc'] as String?,
      contactNumber: json['contact_number'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$OwnerVOToJson(OwnerVO instance) => <String, dynamic>{
      'owner_name': instance.ownerName,
      'gender': instance.gender,
      'date_of_birth': instance.dateOfBirth?.toIso8601String(),
      'race': instance.race,
      'nationality': instance.nationality,
      'nrc': instance.nrc,
      'contact_number': instance.contactNumber,
      'email': instance.email,
    };

ResidentVO _$ResidentVOFromJson(Map<String, dynamic> json) => ResidentVO(
      residentName: json['resident_name'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: json['date_of_birth'] == null
          ? null
          : DateTime.parse(json['date_of_birth'] as String),
      race: json['race'] as String?,
      nationality: json['nationality'] as String?,
      nrc: json['nrc'] as String?,
      contactNumber: json['contact_number'] as String?,
      relatedToOwner: json['related_to_owner'] as String?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$ResidentVOToJson(ResidentVO instance) =>
    <String, dynamic>{
      'resident_name': instance.residentName,
      'gender': instance.gender,
      'date_of_birth': instance.dateOfBirth?.toIso8601String(),
      'race': instance.race,
      'nationality': instance.nationality,
      'nrc': instance.nrc,
      'contact_number': instance.contactNumber,
      'related_to_owner': instance.relatedToOwner,
      '_id': instance.id,
    };
