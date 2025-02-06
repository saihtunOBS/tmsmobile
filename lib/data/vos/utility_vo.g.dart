// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utility_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UtilityVO _$UtilityVOFromJson(Map<String, dynamic> json) => UtilityVO(
      unit: json['unit'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      rate: (json['rate'] as num?)?.toInt(),
      title: json['title'] as String?,
      rateType: json['rate_type'] as String?,
      thisMonth: (json['this_month'] as num?)?.toInt(),
      previousMonth: (json['previous_month'] as num?)?.toInt(),
      amount: (json['amount'] as num?)?.toInt(),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$UtilityVOToJson(UtilityVO instance) => <String, dynamic>{
      'unit': instance.unit,
      'qty': instance.qty,
      'rate': instance.rate,
      'title': instance.title,
      'rate_type': instance.rateType,
      'this_month': instance.thisMonth,
      'previous_month': instance.previousMonth,
      'amount': instance.amount,
      '_id': instance.id,
    };
