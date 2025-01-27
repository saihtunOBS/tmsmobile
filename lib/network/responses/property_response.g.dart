// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyResponse _$PropertyResponseFromJson(Map<String, dynamic> json) =>
    PropertyResponse(
      status: json['success'] as bool?,
      message: json['messaage'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => RoomShopVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PropertyResponseToJson(PropertyResponse instance) =>
    <String, dynamic>{
      'success': instance.status,
      'messaage': instance.message,
      'data': instance.data,
    };
