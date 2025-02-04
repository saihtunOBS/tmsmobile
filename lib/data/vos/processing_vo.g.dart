// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'processing_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessingVO _$ProcessingVOFromJson(Map<String, dynamic> json) => ProcessingVO(
      status: (json['status'] as num?)?.toInt(),
      processingDate: json['processing_date'] as String?,
      processingDescription: json['processing_description'] as String?,
    );

Map<String, dynamic> _$ProcessingVOToJson(ProcessingVO instance) =>
    <String, dynamic>{
      'status': instance.status,
      'processing_date': instance.processingDate,
      'processing_description': instance.processingDescription,
    };
