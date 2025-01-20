// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseHoldRequest _$HouseHoldRequestFromJson(Map<String, dynamic> json) =>
    HouseHoldRequest(
      json['register_date'] as String?,
      json['move_in_date'] as String?,
      json['emergency_contact_number'] as String?,
      (json['information'] as List<dynamic>)
          .map((e) => HouseHold.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HouseHoldRequestToJson(HouseHoldRequest instance) =>
    <String, dynamic>{
      'register_date': instance.registerDate,
      'move_in_date': instance.moveInDate,
      'emergency_contact_number': instance.emergencyContactNumber,
      'information': instance.information,
    };

HouseHold _$HouseHoldFromJson(Map<String, dynamic> json) => HouseHold(
      type: (json['type'] as num?)?.toInt(),
      name: json['name'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: json['date_of_birth'] == null
          ? null
          : DateTime.parse(json['date_of_birth'] as String),
      race: json['race'] as String?,
      nationality: json['nationality'] as String?,
      nrc: json['nrc'] as String?,
      nrcType: (json['nrc_type'] as num?)?.toInt(),
      contactNumber: json['contact_number'] as String?,
      email: json['email'] as String?,
      relatedToOwner: json['related_to_owner'] as String?,
    );

Map<String, dynamic> _$HouseHoldToJson(HouseHold instance) => <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'gender': instance.gender,
      'date_of_birth': instance.dateOfBirth?.toIso8601String(),
      'race': instance.race,
      'nationality': instance.nationality,
      'nrc': instance.nrc,
      'nrc_type': instance.nrcType,
      'contact_number': instance.contactNumber,
      if (instance.email case final value?) 'email': value,
      if (instance.relatedToOwner case final value?) 'related_to_owner': value,
    };
