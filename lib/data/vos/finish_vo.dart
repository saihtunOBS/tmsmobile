import 'package:json_annotation/json_annotation.dart';

import 'invoice_setting_vo.dart';
import 'quotation_detail_vo.dart';
part 'finish_vo.g.dart';

@JsonSerializable()
class FinishedVO {
  final int? status;
  final String? shop;
  final String? issue;
  final String? tenant;
  final List<String>? attach;
  final String? description;
  @JsonKey(name: "finised_date")
  final String? finishedDate;
  final List<QuotationDetailVO>? details;
  @JsonKey(name: "invoice_setting")
  final InvoiceSettingVO? invoiceSetting;
  @JsonKey(name: "sub_total")
  final int? subTotal;
  @JsonKey(name: "grand_total")
  final int? grandTotal;

  FinishedVO(
      {this.status,
      this.shop,
      this.issue,
      this.tenant,
      this.attach,
      this.description,
      this.finishedDate,
      this.details,
      this.invoiceSetting,
      this.subTotal,
      this.grandTotal});

  factory FinishedVO.fromJson(Map<String, dynamic> json) =>
      _$FinishedVOFromJson(json);

  Map<String, dynamic> toJson() => _$FinishedVOToJson(this);
}