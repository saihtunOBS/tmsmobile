// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseholdResponse _$HouseholdResponseFromJson(Map<String, dynamic> json) =>
    HouseholdResponse(
      status: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => HouseHoldVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HouseholdResponseToJson(HouseholdResponse instance) =>
    <String, dynamic>{
      'success': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
