// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingVO _$PendingVOFromJson(Map<String, dynamic> json) => PendingVO(
      status: (json['status'] as num?)?.toInt(),
      shop: json['shop'] as String?,
      issue: json['issue'] as String?,
      tenant: json['tenant'] as String?,
      attach:
          (json['attach'] as List<dynamic>?)?.map((e) => e as String).toList(),
      description: json['description'] as String?,
      pendingDate: json['pending_date'] as String?,
    );

Map<String, dynamic> _$PendingVOToJson(PendingVO instance) => <String, dynamic>{
      'status': instance.status,
      'shop': instance.shop,
      'issue': instance.issue,
      'tenant': instance.tenant,
      'attach': instance.attach,
      'description': instance.description,
      'pending_date': instance.pendingDate,
    };
