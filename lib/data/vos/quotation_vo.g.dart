// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotation_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuotationVO _$QuotationVOFromJson(Map<String, dynamic> json) => QuotationVO(
      status: (json['status'] as num?)?.toInt(),
      shop: json['shop'] as String?,
      date: json['quotation_date'] as String?,
      issue: json['issue'] as String?,
      tenant: json['tenant'] as String?,
      attach:
          (json['attach'] as List<dynamic>?)?.map((e) => e as String).toList(),
      description: json['description'] as String?,
      details: (json['details'] as List<dynamic>?)
          ?.map((e) => QuotationDetailVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      invoiceSetting: json['invoice_setting'] == null
          ? null
          : InvoiceSettingVO.fromJson(
              json['invoice_setting'] as Map<String, dynamic>),
      subTotal: (json['sub_total'] as num?)?.toInt(),
      grandTotal: (json['grand_total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$QuotationVOToJson(QuotationVO instance) =>
    <String, dynamic>{
      'status': instance.status,
      'shop': instance.shop,
      'issue': instance.issue,
      'tenant': instance.tenant,
      'attach': instance.attach,
      'description': instance.description,
      'quotation_date': instance.date,
      'details': instance.details,
      'invoice_setting': instance.invoiceSetting,
      'sub_total': instance.subTotal,
      'grand_total': instance.grandTotal,
    };
