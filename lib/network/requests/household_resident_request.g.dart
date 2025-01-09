// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household_resident_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseholdResidentRequest _$HouseholdResidentRequestFromJson(
        Map<String, dynamic> json) =>
    HouseholdResidentRequest(
      type: (json['type'] as num?)?.toInt(),
      ownerName: json['resident_name'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      race: json['race'] as String?,
      nationality: json['nationality'] as String?,
      nrc: json['nrc'] as String?,
      nrcType: (json['nrc_type'] as num?)?.toInt(),
      contactNumber: json['contact_number'] as String?,
      relatedToOwner: json['related_to_owner'] as String?,
    );

Map<String, dynamic> _$HouseholdResidentRequestToJson(
        HouseholdResidentRequest instance) =>
    <String, dynamic>{
      'type': instance.type,
      'resident_name': instance.ownerName,
      'gender': instance.gender,
      'date_of_birth': instance.dateOfBirth,
      'race': instance.race,
      'nationality': instance.nationality,
      'nrc': instance.nrc,
      'nrc_type': instance.nrcType,
      'contact_number': instance.contactNumber,
      'related_to_owner': instance.relatedToOwner,
    };
