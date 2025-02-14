// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillingVO _$BillingVOFromJson(Map<String, dynamic> json) => BillingVO(
      id: json['_id'] as String?,
      tenant: json['tenant'] as String?,
      businessUnit: json['business_unit'] as String?,
      invoiceCode: json['invoice_code'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      dueDate: json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date'] as String),
      month: json['month'] as String?,
      shop: (json['shop'] as List<dynamic>?)?.map((e) => e as String).toList(),
      payment: json['payment'],
      invoiceNameType: json['invoice_name_type'] as String?,
      invoiceDirection: json['invoice_direction'],
      invoiceType: json['invoice_type'],
      transactionType: json['transaction_type'],
      paymentType: json['payment_type'],
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      downPayment: (json['down_payment'] as num?)?.toDouble(),
      subTotal: (json['sub_total'] as num?)?.toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      discountType: json['discount_type'],
      tax: (json['tax'] as num?)?.toDouble(),
      lateFee: (json['late_fee'] as num?)?.toDouble(),
      grandTotal: (json['grand_total'] as num?)?.toDouble(),
      remainingAmount: (json['remaining_amount'] as num?)?.toDouble(),
      status: (json['status'] as num?)?.toInt(),
      paymentStatus: json['payment_status'],
      statusInstallment: json['status_installment'],
      utilities: (json['utilities'] as List<dynamic>?)
          ?.map((e) => UtilityVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentList: json['payment_list'] as List<dynamic>?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BillingVOToJson(BillingVO instance) => <String, dynamic>{
      '_id': instance.id,
      'tenant': instance.tenant,
      'business_unit': instance.businessUnit,
      'invoice_code': instance.invoiceCode,
      'date': instance.date?.toIso8601String(),
      'due_date': instance.dueDate?.toIso8601String(),
      'month': instance.month,
      'shop': instance.shop,
      'invoice_name_type': instance.invoiceNameType,
      'invoice_direction': instance.invoiceDirection,
      'invoice_type': instance.invoiceType,
      'transaction_type': instance.transactionType,
      'payment_type': instance.paymentType,
      'total_amount': instance.totalAmount,
      'down_payment': instance.downPayment,
      'sub_total': instance.subTotal,
      'discount': instance.discount,
      'discount_type': instance.discountType,
      'tax': instance.tax,
      'late_fee': instance.lateFee,
      'grand_total': instance.grandTotal,
      'payment': instance.payment,
      'remaining_amount': instance.remainingAmount,
      'status': instance.status,
      'payment_status': instance.paymentStatus,
      'status_installment': instance.statusInstallment,
      'utilities': instance.utilities,
      'payment_list': instance.paymentList,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.version,
    };
