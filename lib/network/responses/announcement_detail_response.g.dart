// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnouncementDetailResponse _$AnnouncementDetailResponseFromJson(
        Map<String, dynamic> json) =>
    AnnouncementDetailResponse(
      status: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : AnnouncementVO.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnnouncementDetailResponseToJson(
        AnnouncementDetailResponse instance) =>
    <String, dynamic>{
      'success': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
