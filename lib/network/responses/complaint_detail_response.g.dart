// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplaintDetailResponse _$ComplaintDetailResponseFromJson(
        Map<String, dynamic> json) =>
    ComplaintDetailResponse(
      status: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ComplaintVO.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComplaintDetailResponseToJson(
        ComplaintDetailResponse instance) =>
    <String, dynamic>{
      'success': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
