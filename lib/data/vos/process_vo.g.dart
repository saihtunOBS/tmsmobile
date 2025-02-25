// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessVO _$ProcessVOFromJson(Map<String, dynamic> json) => ProcessVO(
      status: (json['status'] as num?)?.toInt(),
      details: (json['details'] as List<dynamic>?)
          ?.map((e) => DetailVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      subTotal: (json['sub_total'] as num?)?.toInt(),
      grandTotal: (json['grand_total'] as num?)?.toInt(),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$ProcessVOToJson(ProcessVO instance) => <String, dynamic>{
      'status': instance.status,
      'details': instance.details,
      'sub_total': instance.subTotal,
      'grand_total': instance.grandTotal,
      '_id': instance.id,
    };

DetailVO _$DetailVOFromJson(Map<String, dynamic> json) => DetailVO(
      description: json['description'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      tax: (json['tax'] as num?)?.toInt(),
      taxType: json['tax_type'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$DetailVOToJson(DetailVO instance) => <String, dynamic>{
      'description': instance.description,
      'qty': instance.qty,
      'price': instance.price,
      'tax': instance.tax,
      'tax_type': instance.taxType,
      'amount': instance.amount,
      '_id': instance.id,
    };
