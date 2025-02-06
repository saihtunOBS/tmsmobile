// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillingResponse _$BillingResponseFromJson(Map<String, dynamic> json) =>
    BillingResponse(
      status: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BillingVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BillingResponseToJson(BillingResponse instance) =>
    <String, dynamic>{
      'success': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
