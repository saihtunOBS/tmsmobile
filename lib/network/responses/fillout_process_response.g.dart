// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fillout_process_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilloutProcessResponse _$FilloutProcessResponseFromJson(
        Map<String, dynamic> json) =>
    FilloutProcessResponse(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FilloutProcessData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$FilloutProcessResponseToJson(
        FilloutProcessResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'message': instance.message,
    };

FilloutProcessData _$FilloutProcessDataFromJson(Map<String, dynamic> json) =>
    FilloutProcessData(
      statusName: json['status_name'] as String?,
      status: (json['status'] as num?)?.toInt(),
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      pendingDate: json['pending_date'] == null
          ? null
          : DateTime.parse(json['pending_date'] as String),
      serviceDate: json['service_date'] as String?,
      approveDate: json['approve_date'] == null
          ? null
          : DateTime.parse(json['approve_date'] as String),
      amount: (json['amount'] as num?)?.toInt(),
      depositAmount: (json['deposit_amount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FilloutProcessDataToJson(FilloutProcessData instance) =>
    <String, dynamic>{
      'status_name': instance.statusName,
      'status': instance.status,
      'photos': instance.photos,
      'pending_date': instance.pendingDate?.toIso8601String(),
      'service_date': instance.serviceDate,
      'approve_date': instance.approveDate?.toIso8601String(),
      'amount': instance.amount,
      'deposit_amount': instance.depositAmount,
    };
