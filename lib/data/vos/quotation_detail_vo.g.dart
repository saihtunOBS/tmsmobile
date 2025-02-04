// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotation_detail_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuotationDetailVO _$QuotationDetailVOFromJson(Map<String, dynamic> json) =>
    QuotationDetailVO(
      description: json['description'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      tax: (json['tax'] as num?)?.toInt(),
      taxType: json['tax_type'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$QuotationDetailVOToJson(QuotationDetailVO instance) =>
    <String, dynamic>{
      'description': instance.description,
      'qty': instance.qty,
      'price': instance.price,
      'tax': instance.tax,
      'tax_type': instance.taxType,
      'amount': instance.amount,
      'id': instance.id,
    };
