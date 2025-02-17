// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'epc_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpcResponse _$EpcResponseFromJson(Map<String, dynamic> json) => EpcResponse(
      status: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => EpcData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EpcResponseToJson(EpcResponse instance) =>
    <String, dynamic>{
      'success': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

EpcData _$EpcDataFromJson(Map<String, dynamic> json) => EpcData(
      id: json['_id'] as String?,
      switchState: (json['switch'] as num?)?.toInt(),
      businessUnit: json['business_unit'] as String?,
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EpcDataToJson(EpcData instance) => <String, dynamic>{
      '_id': instance.id,
      'switch': instance.switchState,
      'business_unit': instance.businessUnit,
      '__v': instance.version,
    };
