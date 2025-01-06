// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household_registration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseholdRegistrationRequest _$HouseholdRegistrationRequestFromJson(
        Map<String, dynamic> json) =>
    HouseholdRegistrationRequest(
      json['register_date'] as String?,
      json['move_in_date'] as String?,
      json['emergency_contact_number'] as String?,
      json['owner'] == null
          ? null
          : OwnerVO.fromJson(json['owner'] as Map<String, dynamic>),
      (json['resident'] as List<dynamic>?)
          ?.map((e) => ResidentVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HouseholdRegistrationRequestToJson(
        HouseholdRegistrationRequest instance) =>
    <String, dynamic>{
      'register_date': instance.registerDate,
      'move_in_date': instance.moveInDate,
      'emergency_contact_number': instance.emergencyContactNumber,
      'owner': instance.owner,
      'resident': instance.resident,
    };
