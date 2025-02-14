import 'package:json_annotation/json_annotation.dart';

import 'utility_vo.dart';

part 'billing_vo.g.dart';

@JsonSerializable()
class BillingVO {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "tenant")
  final String? tenant;

  @JsonKey(name: "business_unit")
  final String? businessUnit;

  @JsonKey(name: "invoice_code")
  final String? invoiceCode;

  @JsonKey(name: "date")
  final DateTime? date;

  @JsonKey(name: "due_date")
  final DateTime? dueDate;

  @JsonKey(name: "month")
  final String? month;

  @JsonKey(name: "shop")
  final List<String>? shop;

  @JsonKey(name: "invoice_name_type")
  final String? invoiceNameType;

  @JsonKey(name: "invoice_direction")
  final dynamic invoiceDirection;

  @JsonKey(name: "invoice_type")
  final dynamic invoiceType;

  @JsonKey(name: "transaction_type")
  final dynamic transactionType;

  @JsonKey(name: "payment_type")
  final dynamic paymentType;

  @JsonKey(name: "total_amount")
  final double? totalAmount;

  @JsonKey(name: "down_payment")
  final double? downPayment;

  @JsonKey(name: "sub_total")
  final double? subTotal;

  @JsonKey(name: "discount")
  final double? discount;

  @JsonKey(name: "discount_type")
  final dynamic discountType;

  @JsonKey(name: "tax")
  final double? tax;

  @JsonKey(name: "late_fee")
  final double? lateFee;

  @JsonKey(name: "grand_total")
  final double? grandTotal;

   @JsonKey(name: "payment")
  final dynamic payment;

  @JsonKey(name: "remaining_amount")
  final double? remainingAmount;

  @JsonKey(name: "status")
  final int? status;

  @JsonKey(name: "payment_status")
  final dynamic paymentStatus;

  @JsonKey(name: "status_installment")
  final dynamic statusInstallment;

  @JsonKey(name: "utilities")
  final List<UtilityVO>? utilities;

  @JsonKey(name: "payment_list")
  final List<dynamic>? paymentList;

  @JsonKey(name: "createdAt")
  final String? createdAt;

  @JsonKey(name: "updatedAt")
  final String? updatedAt;

  @JsonKey(name: "__v")
  final int? version;

  BillingVO({
    this.id,
    this.tenant,
    this.businessUnit,
    this.invoiceCode,
    this.date,
    this.dueDate,
    this.month,
    this.shop,
    this.payment,
    this.invoiceNameType,
    this.invoiceDirection,
    this.invoiceType,
    this.transactionType,
    this.paymentType,
    this.totalAmount,
    this.downPayment,
    this.subTotal,
    this.discount,
    this.discountType,
    this.tax,
    this.lateFee,
    this.grandTotal,
    this.remainingAmount,
    this.status,
    this.paymentStatus,
    this.statusInstallment,
    this.utilities,
    this.paymentList,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory BillingVO.fromJson(Map<String, dynamic> json) =>
      _$BillingVOFromJson(json);

  Map<String, dynamic> toJson() => _$BillingVOToJson(this);
}
