// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingResponse _$ParkingResponseFromJson(Map<String, dynamic> json) =>
    ParkingResponse(
      status: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PropertyInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ParkingResponseToJson(ParkingResponse instance) =>
    <String, dynamic>{
      'success': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
