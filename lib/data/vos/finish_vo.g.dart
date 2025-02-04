// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finish_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinishedVO _$FinishedVOFromJson(Map<String, dynamic> json) => FinishedVO(
      status: (json['status'] as num?)?.toInt(),
      shop: json['shop'] as String?,
      issue: json['issue'] as String?,
      tenant: json['tenant'] as String?,
      attach:
          (json['attach'] as List<dynamic>?)?.map((e) => e as String).toList(),
      description: json['description'] as String?,
      finishedDate: json['finised_date'] as String?,
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

Map<String, dynamic> _$FinishedVOToJson(FinishedVO instance) =>
    <String, dynamic>{
      'status': instance.status,
      'shop': instance.shop,
      'issue': instance.issue,
      'tenant': instance.tenant,
      'attach': instance.attach,
      'description': instance.description,
      'finised_date': instance.finishedDate,
      'details': instance.details,
      'invoice_setting': instance.invoiceSetting,
      'sub_total': instance.subTotal,
      'grand_total': instance.grandTotal,
    };
