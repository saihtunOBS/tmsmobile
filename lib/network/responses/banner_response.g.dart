// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerResponse _$BannerResponseFromJson(Map<String, dynamic> json) =>
    BannerResponse(
      status: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : BannerVO.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BannerResponseToJson(BannerResponse instance) =>
    <String, dynamic>{
      'success': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
