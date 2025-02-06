// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_status_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaintenanceStatusRequest _$MaintenanceStatusRequestFromJson(
        Map<String, dynamic> json) =>
    MaintenanceStatusRequest(
      (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MaintenanceStatusRequestToJson(
        MaintenanceStatusRequest instance) =>
    <String, dynamic>{
      'status': instance.status,
    };
