// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorVO _$ErrorVOFromJson(Map<String, dynamic> json) => ErrorVO(
      status: json['success'] as bool?,
      message: json['message'] as String?,
      error: json['error'],
    );

Map<String, dynamic> _$ErrorVOToJson(ErrorVO instance) => <String, dynamic>{
      'success': instance.status,
      'message': instance.message,
      'error': instance.error,
    };
