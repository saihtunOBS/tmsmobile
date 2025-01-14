// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyResponse _$EmergencyResponseFromJson(Map<String, dynamic> json) =>
    EmergencyResponse(
      status: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => EmergencyVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EmergencyResponseToJson(EmergencyResponse instance) =>
    <String, dynamic>{
      'success': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
