// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResponse _$NotificationResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationResponse(
      status: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => NotificationVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotificationResponseToJson(
        NotificationResponse instance) =>
    <String, dynamic>{
      'success': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
