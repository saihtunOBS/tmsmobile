// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household_owner_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseholdOwnerRequest _$HouseholdOwnerRequestFromJson(
        Map<String, dynamic> json) =>
    HouseholdOwnerRequest(
      type: (json['type'] as num?)?.toInt(),
      ownerName: json['owner_name'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      race: json['race'] as String?,
      nationality: json['nationality'] as String?,
      nrc: json['nrc'] as String?,
      nrcType: (json['nrc_type'] as num?)?.toInt(),
      contactNumber: json['contact_number'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$HouseholdOwnerRequestToJson(
        HouseholdOwnerRequest instance) =>
    <String, dynamic>{
      'type': instance.type,
      'owner_name': instance.ownerName,
      'gender': instance.gender,
      'date_of_birth': instance.dateOfBirth,
      'race': instance.race,
      'nationality': instance.nationality,
      'nrc': instance.nrc,
      'nrc_type': instance.nrcType,
      'contact_number': instance.contactNumber,
      'email': instance.email,
    };
