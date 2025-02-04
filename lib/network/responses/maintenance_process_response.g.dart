// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_process_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaintenanceProcessResponse _$MaintenanceProcessResponseFromJson(
        Map<String, dynamic> json) =>
    MaintenanceProcessResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              MaintenanceProcessDataVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MaintenanceProcessResponseToJson(
        MaintenanceProcessResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
