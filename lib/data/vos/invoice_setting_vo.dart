import 'package:json_annotation/json_annotation.dart';
part 'invoice_setting_vo.g.dart';

@JsonSerializable()
class InvoiceSettingVO {
  final String? id;
  @JsonKey(name: "invoice_type")
  final String? invoiceType;
  @JsonKey(name: "invoice_number_prefix")
  final String? invoiceNumberPrefix;
  @JsonKey(name: "invoice_validity")
  final int? invoiceValidity;
  @JsonKey(name: "due_validity")
  final int? dueValidity;
  @JsonKey(name: "remainder_days")
  final int? remainderDays;
  final int? tax;
  @JsonKey(name: "penalty_type")
  final String? penaltyType;
  @JsonKey(name: "penalty_fee")
  final int? penaltyFee;
  @JsonKey(name: "business_unit")
  final String? businessUnit;

  InvoiceSettingVO(
      {this.id,
      this.invoiceType,
      this.invoiceNumberPrefix,
      this.invoiceValidity,
      this.dueValidity,
      this.remainderDays,
      this.tax,
      this.penaltyType,
      this.penaltyFee,
      this.businessUnit});

  factory InvoiceSettingVO.fromJson(Map<String, dynamic> json) =>
      _$InvoiceSettingVOFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceSettingVOToJson(this);
}