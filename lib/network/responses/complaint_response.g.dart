// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplaintResponse _$ComplaintResponseFromJson(Map<String, dynamic> json) =>
    ComplaintResponse(
      status: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ComplaintVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ComplaintResponseToJson(ComplaintResponse instance) =>
    <String, dynamic>{
      'success': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
