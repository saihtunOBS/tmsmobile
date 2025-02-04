// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_setting_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceSettingVO _$InvoiceSettingVOFromJson(Map<String, dynamic> json) =>
    InvoiceSettingVO(
      id: json['id'] as String?,
      invoiceType: json['invoice_type'] as String?,
      invoiceNumberPrefix: json['invoice_number_prefix'] as String?,
      invoiceValidity: (json['invoice_validity'] as num?)?.toInt(),
      dueValidity: (json['due_validity'] as num?)?.toInt(),
      remainderDays: (json['remainder_days'] as num?)?.toInt(),
      tax: (json['tax'] as num?)?.toInt(),
      penaltyType: json['penalty_type'] as String?,
      penaltyFee: (json['penalty_fee'] as num?)?.toInt(),
      businessUnit: json['business_unit'] as String?,
    );

Map<String, dynamic> _$InvoiceSettingVOToJson(InvoiceSettingVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoice_type': instance.invoiceType,
      'invoice_number_prefix': instance.invoiceNumberPrefix,
      'invoice_validity': instance.invoiceValidity,
      'due_validity': instance.dueValidity,
      'remainder_days': instance.remainderDays,
      'tax': instance.tax,
      'penalty_type': instance.penaltyType,
      'penalty_fee': instance.penaltyFee,
      'business_unit': instance.businessUnit,
    };
