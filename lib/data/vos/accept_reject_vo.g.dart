// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_reject_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcceptRejectVO _$AcceptRejectVOFromJson(Map<String, dynamic> json) =>
    AcceptRejectVO(
      status: (json['status'] as num?)?.toInt(),
      acceptRejectDate: json['accept_reject_date'] as String?,
    );

Map<String, dynamic> _$AcceptRejectVOToJson(AcceptRejectVO instance) =>
    <String, dynamic>{
      'status': instance.status,
      'accept_reject_date': instance.acceptRejectDate,
    };
